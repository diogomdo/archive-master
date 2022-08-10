#!/bin/sh

set -e
#set -o pipefail

DIR=../croupier/resources
FILE=$DIR/events.db
BACKUP_DB_NAME=$(date '+%Y%m%d')-events.backup

rclone_db_command () {
  rclone move --no-traverse $DIR --include "*.backup" gdrive:croupier/database_backup -P
}

[ -f $FILE ] && echo "Database found."
sqlite3 $FILE ".backup '$DIR/$BACKUP_DB_NAME'"

[ -f "$DIR/$BACKUP_DB_NAME" ] && rclone_db_command