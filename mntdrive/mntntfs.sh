#!/bin/bash

# List connected devices
echo "These are the devices currently connected to the system:"
lsblk
echo ""

# Prompt the user to enter the device name
read -p "Enter the device name (e.g., /dev/sda2): " DEVICE

# Default mount point
DEFAULT_MOUNT_POINT="/mnt/ntfs"

# Ask for a custom mount point (optional)
read -p "Where do you want to mount? (Default: $DEFAULT_MOUNT_POINT): " MOUNT_POINT

# Use the default if input is empty
MOUNT_POINT=${MOUNT_POINT:-$DEFAULT_MOUNT_POINT}

# Check if the mount point exists, create if not
if [ ! -d "$MOUNT_POINT" ]; then
  echo "Creating mount point at $MOUNT_POINT..."
  sudo mkdir -p "$MOUNT_POINT"
else
  echo "Mount point $MOUNT_POINT already exists."
fi

# Mount the NTFS partition
echo "Mounting $DEVICE to $MOUNT_POINT..."
sudo mount -t ntfs-3g "$DEVICE" "$MOUNT_POINT"

# Verify the mount
echo "Verifying the mount..."
ls "$MOUNT_POINT"

echo "Mount successful at $MOUNT_POINT!"
