#!/bin/bash

set -e
trap 'echo "$(date "+%Y-%m-%d %H:%M:%S") - ERROR at line $LINENO: $BASH_COMMAND" >> /var/log/script_errors.log' ERR

TIMESTAMP="$(date "+%Y-%m-%d_%H:%M:%S")"
FILE="/var/log/nginx.log"
LOG_FILE="/var/log/changes.log"
MAX_SIZE=5
log(){
	echo " $1-$TIMESTAMP " >> "$LOG_FILE"
}

main(){
if [ -f "$FILE" ]; then
	SIZE="$(du -m /var/log/nginx.log | awk 'NR==1 {print $1}')"
	if [ "$SIZE" -ge "$MAX_SIZE" ]; then
		mv "$FILE" "$FILE.$TIMESTAMP"
		log "File renamed"

		gzip "$FILE.$TIMESTAMP"
		log "Arcive for log created"
		
		touch "$FILE"
		log "File created"

		chown nginx:nginx "$FILE"	
		chmod 644 "$FILE"
		log "New log file created with correct permission"
		ls -1t "$FILE".*.gz 2> /dev/null | tail -n +6 | while read file
			do 
				rm -f "$file"
				log "$file removed"
			done
	else 
		log "Size within range"
	fi
else 
	log "$FILE doesn't exist" 
	exit 2	
fi
}

main
