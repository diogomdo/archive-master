# TODO
- [x] Define logs folder structure
- [x] Script to normalize log file names as backfill.
- [x] Organize log files per month.
- [x] Zip folder with respective log files order by year and month.
- [x] Logs of the current month can be moved to their respective folder
  - Not zipped.
- [ ] Log files with different name structure should be moved to specific folder
  - Not be zipped
- [x] Merge commands or calls into one file.
  - This only file should contain also rclone command.
- [x] rclone command must only copy zip files.
  - Confirm copy, must eliminate zips from origin folder.


# Rclone commands

$ rclone lsl gdrive:croupier/logs_backup

Lists all files from directory "/logs_backup.

$ rclone move --no-traverse ./resources/logs --include "*.zip" gdrive:croupier/logs_backup -P

Copies zip files to destiny and removes from source.

# PM2 commands

## logs backup

pm2 start logs_backup.sh --name logs-backup --interpreter sh --max-memory-restart 90M --cron "*/15 * * * *"

## db backup

pm2 start db_backup.sh --name db-backup --interpreter sh --max-memory-restart 90M --cron "*/15 * * * *"
