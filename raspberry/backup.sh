#!/bin/bash

# Set variables for the source SSD and destination SD card mount point
SRC_DEV="/boot/firmware"      # Change if your SSD uses another device name
DEST_PATH="/mnt/sdcard/backups" # Change if your SD card is mounted elsewhere
BACKUP_FILE="${DEST_PATH}/ssd_backup.img.gz"

# Check destination exists
if [ ! -d "$DEST_PATH" ]; then
  echo "Destination path $DEST_PATH does not exist!"
  exit 1
fi

# Create backup (compressed, overwrites previous)
sudo dd if="$SRC_DEV" bs=4M status=progress | gzip -c > "$BACKUP_FILE"

# Sync filesystems before exit
sync
echo "Backup complete: $BACKUP_FILE"
