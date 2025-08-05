"""Upload AOI files with CLI."""
import os
import subprocess
import sys
from collections import namedtuple
from datetime import datetime
from typing import List

from loguru import logger as logging

BUCKET_NAME = "aoi_tracking"

FileInfo = namedtuple("FileInfo", ["filename", "modified_time"])


def get_gcs_folder_contents(customer_name: str, base_name: str) -> str:
    """Retrieve the last modified filename within the AOI GCS folder `customer_name`.

    Parameters
    ----------
    customer_name : str
        The customer folder name in GCS.
    base_name: str
        The base name of the AOI file to be uploaded for a customer.
    Returns
    -------
    str
        Either the last modified filename or None if the file does not exist
    """
    folder_uri = f"gs://{BUCKET_NAME}/{customer_name}/{base_name}"
    try:
        cmd = ["gcloud", "storage", "ls", "-l", folder_uri]  # '-l' includes timestamps
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

        if filename:  # Ensure filename is valid
            files_info.append(FileInfo(filename, modified_time))
    return filename


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


def get_next_aoi_version_filename(
    base_name: str, file_extension: str, latest_filename: str
) -> str:
    """Determine the next version for a provided `original_filename`.

    Parameters
    ----------
    base_name : str
        The base_name of the `original_filename` to be uploaded
    file_extension: str
        The extension of the `original_filename`
    latest_filename : str
        The last modified filename from a GCS client folder.

    Returns
    -------
    str
        The new filename with the incremented version (e.g., "report_v2.csv").
    """
    if latest_filename is None:
        new_version = 1
    else:
        # Expecting filenames like "report_vN.csv"
        parts = latest_filename.split("_v")
        if len(parts) == 2:
            try:
                ver_str = parts[1].split(file_extension)[0]
                version = int(ver_str)
                new_version = version + 1
            except ValueError:
                new_version = 1
        else:
            new_version = 1

    return f"{base_name}_v{new_version}{file_extension}"


def get_versioned_filename(
    customer_name: str, base_name: str, file_extension: str, original_filename: str
) -> str:
    """Get most recent file version of the latest AOI file.

    Parameters
    ----------
    customer_name : str
        The customer folder name in GCS.
    base_name : str
        The base_name of the `original_filename` to be uploaded
    file_extension: str
        The extension of the `original_filename`
    original_filename : str
        The base (local) file name we want to upload.

    Returns
    -------
    str
        A filename that accounts for existing versions in GCS.
    """
    folder_contents = get_gcs_folder_contents(customer_name, base_name)
    latest_filename = get_latest_filename(folder_contents)
    versioned_filename = get_next_aoi_version_filename(
        base_name, file_extension, latest_filename
    )
    logging.success(f"Latest AOI will be name {versioned_filename}")
    return versioned_filename


def upload_file(customer_name: str, local_path: str):
    """Upload a file to `customer_name` folder.

    Parameters
    ----------
    customer_name : str
        The name of the customer (sub-folder in GCS).
    local_path : str
        Path to the local file to upload.

    Returns
    -------
    None

    Raises
    ------
    SystemExit
        If the local_path is invalid or if the gcloud command fails.
    """
    if not os.path.isfile(local_path):
        logging.error("Local file '%s' does not exist.", local_path)
        sys.exit(1)

    original_filename = os.path.basename(local_path)
    base_name, file_extension = os.path.splitext(original_filename)

    # Decide what the final name in GCS should be
    versioned_filename = get_versioned_filename(
        customer_name=customer_name,
        base_name=base_name,
        file_extension=file_extension,
        original_filename=original_filename,
    )
    # TODO handle aoi_base_name Usage
    remote_uri = f"gs://{BUCKET_NAME}/{customer_name}/{base_name}/{versioned_filename}"

    logging.info("Uploading '%s' to '%s'...", local_path, remote_uri)
    cmd = ["gcloud", "storage", "cp", local_path, remote_uri]
    try:
        subprocess.run(cmd, check=True)
        logging.info("Upload succeeded.")
    except subprocess.CalledProcessError as e:
        logging.error("Upload failed with error code %d.", e.returncode)
        sys.exit(1)
