#!/bin/bash

# Variables
BACKUP_DIR="/home/rambo/gitea_backups"
TIMESTAMP=$(date +"%Y_%j_%H%M%S") # Year_DayOfYear_Time
ARCHIVE_NAME="gitea_backup_${TIMESTAMP}.tar.gz"
TARGET_ARCHIVE="${BACKUP_DIR}/${ARCHIVE_NAME}"

# Directories to backup
DIRS=(
  "/home/rigslab/backups/databases"
  "/home/git/gitea-repositories"
  "/var/lib/gitea/custom"
  "/var/lib/gitea/data"
)

# File to backup
CONFIG_FILE="/etc/gitea/app.ini"

# Ensure the backup directory exists
mkdir -p "$BACKUP_DIR"

# Create the archive
tar -czvf "$TARGET_ARCHIVE" "${DIRS[@]}" "$CONFIG_FILE"

# Set the ownership to rambo:rambo
chown rambo:rambo "$TARGET_ARCHIVE"

# Output success message
echo "Backup completed: $TARGET_ARCHIVE"