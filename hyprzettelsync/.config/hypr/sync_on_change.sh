#!/bin/bash

# Path to your local folder
LOCAL_FOLDER="/mnt/D/ZettenKasten"

# Path to your Google Drive folder
REMOTE_FOLDER="gdrive:/My Notes/ZettenKasten"

# Run inotifywait to monitor the folder for any file changes
inotifywait -m -r -e modify,create,delete "$LOCAL_FOLDER" | while read; do
    echo "Change detected. Syncing..."
    rclone sync "$LOCAL_FOLDER" "$REMOTE_FOLDER" --progress
done
