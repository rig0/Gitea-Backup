#!/bin/bash

# Load the .env file if it exists
if [ -f "$(dirname "$0")/.env" ]; then
    export $(grep -v '^#' "$(dirname "$0")/.env" | xargs)
fi

# Check for required env variables
if [[ -z "$BACKUP_API_TOKEN" || -z "$BACKUP_DIR" || -z "$BACKUP_USER" ]]; then
    echo "Error: One or more required variables are not set."
    exit 1
fi

# Variables
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

# Set the ownership to $BACKUP_USER:$BACKUP_USER
chown $BACKUP_USER:$BACKUP_USER "$TARGET_ARCHIVE"

# Call API to pick up
curl --location 'https://backups.rigslab.com/gitea' \
--header "Content-Type: application/json" \
--header "Authorization: Bearer $BACKUP_API_TOKEN" \
--data "{
    \"backup_folder\": \"$BACKUP_DIR\"
}"

# Output success message
echo "Backup completed: $TARGET_ARCHIVE"