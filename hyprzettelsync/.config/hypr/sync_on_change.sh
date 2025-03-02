#!/bin/bash

# Path to your local folder
LOCAL_FOLDER="$HOME/my-drive/data/ZettelKasten/"

# Path to your Google Drive folder
REMOTE_FOLDER="gdrive:My Notes/ZettenKasten"

# Run inotifywait to monitor the folder for changes
inotifywait -m -r -e modify,create,delete --format "%w%f %e" "$LOCAL_FOLDER" | while read -r file event; do
    echo "Change detected: $file ($event)"
    sleep 2  # Prevent excessive syncing
    rclone sync "$LOCAL_FOLDER" "$REMOTE_FOLDER" --progress --fast-list --ignore-existing
done  # <-- This was missing
