#!/bin/bash

# Backup destination folder on SD card
BACKUP_FOLDER="/path/to/sdcard/backups"

# Default backup file name
BACKUP_FILE="raspberry_pi_backup.tar.gz"

# If a parameter is given, use it as backup file name
if [ ! -z "$1" ]; then
  BACKUP_FILE="$1"
fi

# Ensure backup folder exists
mkdir -p "$BACKUP_FOLDER"

# Full path to backup file
FULL_BACKUP_PATH="$BACKUP_FOLDER/$BACKUP_FILE"

# Variables
SSD_MOUNT="/"  # root of Raspberry Pi OS on SSD

# Create backup with exclusions
sudo tar --exclude='/tmp/*'\
         --exclude='/var/tmp/*' \
         --exclude='/var/cache/*' \
         --exclude='/var/log/*' \
         --exclude='/proc/*' \
         --exclude='/sys/*' \
         --exclude='/dev/*' \
         --exclude='/run/*' \
         --exclude='/mnt/*' \
         --exclude='/media/*' \
         --exclude='/lost+found' \
         --exclude='/swapfile' \
         --exclude='/swap.img' \
         --exclude='/var/lib/docker/*' \
         --exclude='/home/*/Downloads/*' \
         --exclude='/home/*/.cache/*' \
         --exclude='/var/lib/rancher/k3s/data/current/bin' \
         --exclude='/var/lib/rancher/k3s/agent/containerd' \
         --exclude='/run/k3s' \
         --exclude='/var/lib/kubelet/pods' \
         --exclude="$FULL_BACKUP_PATH" \
         -czpf "$FULL_BACKUP_PATH" -C "$SSD_MOUNT" .

# Output result
if [ $? -eq 0 ]; then
  echo "Backup created successfully: $FULL_BACKUP_PATH"
else
  echo "Backup creation failed!"
fi
