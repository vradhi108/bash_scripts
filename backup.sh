#!/bin/bash

SRC_DIR="/opt/app/data"
DEST_DIR="/opt/backups"
DATE="$(date "+%Y-%m-%d")"
TIMESTAMP="$(date "+%Y-%m-%d %H:%M:%S")"
LOGFILE="/var/log/backup.log"

create_archive(){
	tar -czf "$DEST_DIR/Backup_data_$DATE.tar.gz" "$SRC_DIR" 
	return $?
}

cleanup(){
	ls -1t "$DEST_DIR/Backup_data_*.tar.gz" 2> /dev/null | tail -n +6 | while read file
                do
                        rm -f "$file"
                       log_message "OLD BACKUP DELETED"
                done
}

log_message(){
	echo "$TIMESTAMP - $1" >> "$LOGFILE"
}

main(){
if [ -d "$SRC_DIR" ]; then
	create_archive
	TAR_STATUS=$?

	if [ $TAR_STATUS -eq 0 ]; then
		log_message  "BACKUP CREATED - SUCCESSFULL"
		cleanup
	else
		log_message "ERROR DURING COMPRESSION"
	fi
else
	log_message "FILE DOEST NOT EXIST - $SRC_DIR"

fi
}

main
