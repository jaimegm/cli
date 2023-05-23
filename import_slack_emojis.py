import os
import requests

SLACK_API_TOKEN = "NE2xWiOUBjwuvgksK131081B"
SLACK_EMOJI_URL = "https://slack.com/services/T01GGRDLX5Y/B04PRDYKAJY/api/emoji.add"

# Set path to directory containing emoji files
emoji_dir = "/Users/jaime/Downloads/emojis"

# Get list of all files in directory
emoji_files = os.listdir(emoji_dir)

# Loop through files and upload each one to Slack
for file in emoji_files:
    if file.endswith(".png") or file.endswith(".jpg") or file.endswith(".gif"):
        # Open the file
        with open(os.path.join(emoji_dir, file), "rb") as f:
            # Upload the emoji to Slack
            r = requests.post(
                SLACK_EMOJI_URL,
                headers={"Authorization": f"Bearer {SLACK_API_TOKEN}"},
                data={"mode": "data", "name": file.split(".")[0], "image": f},
            )

            # Check for errors
            if r.status_code != 200:
                print("Error uploading emoji: {}".format(r.json()["error"]))
            else:
                print("Emoji {} uploaded successfully.".format(file.split(".")[0]))
