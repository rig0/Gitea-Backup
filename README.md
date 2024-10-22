# Gitea-Backup

A script to backup gitea folders and ini. 

#### *Intended to use with [Backup-API](https://rigslab.com/Rambo/Backup-API) to backup to a remote server. Comment out API call if not using Backup-API.*

### Prerequisites
```bash
sudo apt install rsync curl
```

### Copy script locally
```bash
curl -O https://rigslab.com/Rambo/Gitea-Backup/raw/branch/main/backup_gitea.sh && chmod +x backup_gitea.sh
```

### Create a .env file in the same directory as the backup script and store the following
```bash
API_URL=https://api.yourserver.com
API_TOKEN=API-Token
BACKUP_DIR=/dir/to/store/backups
BACKUP_USER=user #this user will have permission to the backup archives
```

### Use `backup_gitea.sh` to back up Gitea database, app.ini, data, custom & repositories
```bash
sudo ./backup_gitea.sh
```