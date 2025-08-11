#!/usr/bin/env bash
#
# This script automatically deletes NTFS Alternate Data Streams named ":Zone.Identifier"
# that appear in WSL when creating or modifying files from Windows Explorer. It uses
# inotifywait to monitor a directory (recursively) for file creation events, and when
# it detects a file ending with ":Zone.Identifier", it removes it immediately. This
# prevents clutter in file listings and avoids issues when working with development
# tools. To run it automatically, install `inotify-tools`, make this script executable,
# create a systemd service pointing to it, and enable the service with:
#   sudo systemctl daemon-reload
#   sudo systemctl enable --now delete-zone-files.service
#

WATCH_DIR="$HOME"

inotifywait -m -r \
  -e create \
  --format '%w%f' "$WATCH_DIR" |
while read FILE; do
    if [[ "$FILE" == *:Zone.Identifier ]]; then
        rm -f "$FILE" && echo "[DELETED] $FILE"
    fi
done
