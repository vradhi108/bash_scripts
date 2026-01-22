#!/bin/bash

#This script automates the backup of application data by creating a compressed archive.

#It uses tar with gzip compression to reduce disk usage and generate a .tar.gz backup file.

#Before performing the backup, the script validates that the source directory exists to avoid runtime errors.

#The script logs the success or failure of the backup operation with timestamps, which helps with auditing and troubleshooting in production environments.

SRC_DIR="/opt/app/data"
DEST_DIR="/opt/backups"
DATE=$(date "+%Y-%m-%d")
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
LOGFILE="/var/log/backup.log"

# -c create archive
# -z gzip compression
# -f file name

if [ -d "$SRC_DIR" ]; then
	tar -czf "$DEST_DIR/data_backup_$DATE.tar.gz" "$SRC_DIR"
	if [ $? -eq 0 ]; then
		echo "BACKUP - SUCCESSFULL - $TIMESTAMP" >> "$LOGFILE"
	else 
		echo "BACKUP - FAILED DURING COMPRESSION - $TIMESTAMP" >> "$LOGFILE"
	fi
tIt creates kjkteelse
	echo "$SRC_DIR DOESN'T EXISTS $TIMESTAMP" >> "$LOGFILE"
fi

