"""Upload AOI files with CLI."""
import os
import subprocess
import sys
from collections import namedtuple
from datetime import datetime
from pathlib import Path
from typing import List

from loguru import logger as logging

FileInfo = namedtuple("FileInfo", ["filename", "modified_time"])


class AoiUploader:
    """Process for uploading AOI files with CLI."""

    BUCKET_NAME = "aoi_tracking"

    def __init__(self, customer_name: str, local_aoi_filepath: str):
        """Initialize standard parameters.

        Parameters
        ----------
        customer_name : str
            The customer folder name in GCS.
        local_aoi_filepath : str
            The local file path to the AOI file to be uploaded.

        Attributes
        ----------
        customer_name : str
            The customer folder name in GCS.
        local_aoi_filepath : pathlib.Path
            The absolute local path of the AOI file.
        base_name : str
            The base name of the AOI file to be uploaded, extracted from the local filepath
            (i.e. the filename without its extension).
        file_extension : str
            The file extension of the AOI file, extracted from the local file path.
        """
        self.customer_name = customer_name
        self.local_aoi_filepath = Path(local_aoi_filepath)
        self.base_name = self.local_aoi_filepath.stem
        self.file_extension = self.local_aoi_filepath.suffix

    def get_gcs_folder_contents(self) -> str:
        """Retrieve the existing files in a gcs `customer_name` folder."""
        folder_uri = f"gs://{self.BUCKET_NAME}/{self.customer_name}/{self.base_name}"
        try:
            cmd = [
                "gcloud",
                "storage",
                "ls",
                "-l",
                folder_uri,
            ]  # '-l' includes timestamps
            result = subprocess.run(cmd, capture_output=True, text=True, check=False)
            if result.returncode != 0:
                logging.warning("No files found in folder: %s", folder_uri)
                return {}
        except FileNotFoundError:
            logging.error(
                "Error: gcloud command not found. Please ensure gcloud is installed and on your PATH."
            )
            sys.exit(1)

        files_info = []
        lines = result.stdout.strip().split("\n")

        for line in lines:
            parts = line.strip().split()
            if len(parts) < 4:
                continue  # Skip invalid lines

            modified_time = (
                f"{parts[0]} {parts[1]}"  # Example format: "2025-03-12 14:30:22"
            )
            filename = parts[-1].split("/")[-1]  # Extract filename from full path

            if filename:
                files_info.append(FileInfo(filename, modified_time))
        return files_info

    @staticmethod
    def get_latest_filename(files_info: List[FileInfo]) -> str:
        """Extract the last modified filename from the `files_info` list.

        Parameters
        ----------
        files_info: List[FileInfo]
            A List of FileInfo objects returned from `get_gcs_folder_contents`

        Returns
        -------
        last_modified_filename: str
            The last modified filename from the `files_info` list. None if no files.
        """
        if files_info:
            last_modified_filename = max(
                files_info, key=lambda x: datetime.strptime(x[1], "%Y-%m-%d %H:%M:%S")
            )
            logging.debug(
                f"Identified existing last modified file: {last_modified_filename}"
            )
            return last_modified_filename.filename
        else:
            return None

    def get_next_aoi_version_filename(self, latest_filename: str) -> str:
        """Determine the next version for a provided `original_filename`.

        Parameters
        ----------
        latest_filename : str
            The last modified filename from a GCS client folder.

        Returns
        -------
        versioned_filename: str
            The new filename with the incremented version (e.g., "report_v2.csv").
        """
        if latest_filename is None:
            new_version = 1
        else:
            # Expecting filenames like "report_vN.csv"
            parts = latest_filename.split("_v")
            if len(parts) == 2:
                try:
                    ver_str = parts[1].split(self.file_extension)[0]
                    version = int(ver_str)
                    new_version = version + 1
                except ValueError:
                    new_version = 1
            else:
                new_version = 1
        versioned_filename = f"{self.base_name}_v{new_version}{self.file_extension}"
        logging.success(f"Latest AOI will be name {versioned_filename}")
        return versioned_filename

    def get_versioned_filename(self) -> str:
        """Get most recent file version of the latest AOI file.

        Returns
        -------
        versioned_filename: str
            A filename that accounts for existing versions in GCS.
        """
        folder_contents = self.get_gcs_folder_contents()
        latest_filename = self.get_latest_filename(folder_contents)
        return self.get_next_aoi_version_filename(latest_filename)

    def upload_file(self):
        """Upload a AOI file to `/customer_name/self.base_name/` folder.

        Raises
        ------
        SystemExit
            If the local_path is invalid or if the gcloud command fails.
        """
        if not os.path.isfile(self.local_aoi_filepath):
            logging.error("Local file '%s' does not exist.", self.local_aoi_filepath)
            sys.exit(1)

        # Decide what the final name in GCS should be
        versioned_filename = self.get_versioned_filename()
        # Create GCS URI
        remote_uri = f"gs://{self.BUCKET_NAME}/{self.customer_name}/{self.base_name}/{versioned_filename}"

        logging.info(f"Uploading {self.local_aoi_filepath} to {remote_uri} ...")
        cmd = ["gcloud", "storage", "cp", self.local_aoi_filepath, remote_uri]
        try:
            subprocess.run(cmd, check=True)
            logging.info("Upload succeeded.")
        except subprocess.CalledProcessError as e:
            logging.error("Upload failed with error code %d.", e.returncode)
            sys.exit(1)
