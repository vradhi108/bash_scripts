#!/bin/bash

#This script automates the backup of application data.

#It first defines variables for the source directory, backup location, and timestamps.
#Before starting the backup, the script validates that the source directory exists using the -d test condition.

#If the directory exists, it performs a recursive copy using cp -r to ensure all files and subdirectories are backed up.
#After the copy operation, the script checks the exit code to determine whether the backup was successful or not.

#Based on the result, it writes a timestamped success or failure message to a log file.
#If the source directory does not exist, the script logs an appropriate error mes#sage instead of failing silently.

SRC_DIR="/opt/app/data"
DEST_DIR="/opt/backups"
DATE="$(date "+%Y-%m-%d")"
LOGFILE="/var/log/backup.log"
TIMESTAMP="$(date "+%Y-%m-%d %H-%M-%S")"

# -d checks if the directory is present or not
#before copying we must check if the file is present or not

#As a devops engineer,we should maintain logs properly and clearly
if [ -d "$SRC_DIR" ]; then
echo "Exists"
cp -r "$SRC_DIR" "$DEST_DIR/data_backup_$DATE"

if [ $? -eq 0 ];then 
echo "$TIMESTAMP - Backup success - $SRC_DIR" >> "$LOGFILE"
else 
echo "$TIMESTAMP - Backup failed during copy" >> "$LOGFILE"
fi
else
echo "Source directory doesn't exist"
fi

