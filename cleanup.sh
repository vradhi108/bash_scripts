#!/bin/bash

#Old and unnecessary backups consume disk space, so to save disk space we use an automated script that automatically removes older backups.

#The -d option is used to check whether the source directory exists. This helps prevent unnecessary errors during script execution.

#We use tar -czf to compress the directory, which reduces disk usage.
#The -c option is used to create the archive,
#-z specifies gzip compression,and -f specifies the archive file name.

#The main logic is to remove old backups while keeping only the most recent five backups.
#We use ls -1t to list the backup files sorted by creation time, with the newest files first.
#The -1 option lists one file per line, and -t sorts by time.

#The output is piped to another command, where we start processing from the 6th backup onward.
#A while read loop is used to delete backups from the 6th file to the oldest one

#Logging is important for auditing and troubleshooting.

#By using timestamps, we can identify when an issue occurred and understand where the script failed.

SRC_DIR="/opt/app/data"
DEST_DIR="/opt/backups"
LOGFILE="/var/log/backup.log"
DATE="$(date "+%Y-%m-%d")"
TIMESTAMP="$(date "+%Y-%m-%d %H:%M:%S")"

if [ -d "$SRC_DIR" ]; then
	tar -czf "$DEST_DIR/Backup_data_$DATE.tar.gz" "$SRC_DIR"
	TAR_STATUS=$?
	ls -1t "$DEST_DIR/Backup_data_*.tar.gz" 2> /dev/null | tail -n +6 | while read file 
	do 
		rm -f "$file"
		echo "$TIMESTAMP - OLD BACKUP DELETED - $file" >> "$LOGFILE"
	done
	if [ $TAR_STATUS -eq 0 ]; then
		echo "BACKUP SUCCESSFULL - $TIMESTAMP" >> "$LOGFILE" 
	else
		echo "ERROR DURING COMPRESSION - $TIMESTAMP" >> "$LOGFILE"
	fi
else
	echo "DIRECTORY NOT PRESENT - $TIMESTAMP" >> "$LOGFILE"
fi

#Old and unnecessary backups consume disk space, so to save disk space we use an automated script that automatically removes older backups.

#The -d option is used to check whether the source directory exists. This helps prevent unnecessary errors during script execution.

#We use tar -czf to compress the directory, which reduces disk usage.
#The -c option is used to create the archive,
#-z specifies gzip compression,and -f specifies the archive file name.

#The main logic is to remove old backups while keeping only the most recent five backups.
#We use ls -1t to list the backup files sorted by creation time, with the newest files first.
#The -1 option lists one file per line, and -t sorts by time.

#The output is piped to another command, where we start processing from the 6th backup onward.
#A while read loop is used to delete backups from the 6th file to the oldest one.

#Logging is important for auditing and troubleshooting.
#By using timestamps, we can identify when an issue occurred and understand where the script failed.
