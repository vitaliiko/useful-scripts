#!/bin/bash

# Default backup folder
BACKUP_DIR="/mnt/sdcard/backups"
# Default backup file name
BACKUP_FILE="os_backup.tar.gz"

# If a parameter is given, use it as backup file name
if [ ! -z "$1" ]; then
  BACKUP_FILE="$1"
fi

BACKUP_DESTINATION="${BACKUP_DIR}/${BACKUP_FILE}"

# Variables
SSD_MOUNT="/"  # root of Raspberry Pi OS on SSD

# Create backup (exclude backup destination to avoid recursion)
sudo tar --exclude='$BACKUP_FILE' -czpf "$BACKUP_DESTINATION" -C "$SSD_MOUNT" .

# Output result
if [ $? -eq 0 ]; then
  echo "Backup created successfully: $BACKUP_FILE"
else
  echo "Backup creation failed!"
fi
