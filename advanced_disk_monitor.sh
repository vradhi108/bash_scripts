#!/bin/bash

TIMESTAMP="$(date "+%Y-%m-%s %H:%M:%S")"
LOG_FILE="/var/log/disk_monitoring.log"

WARNING=80
CRITICAL=90

df -hP | grep -vE '^Filesystem|tmpfs|devtmpfs' | while read filesystem size used avail percent mount
	do
		USAGE=${percent%\%}
		
		if [ "$USAGE" -ge "$CRITICAL" ]; then
			echo "$TIMESTAMP - CRITICAL - $mount usage is ${USAGE}%" >> "$LOG_FILE" 
			EXIT_CODE=2
		elif [ "$USAGE" -ge "$WARNING" ]; then
			echo "$TIMESTAMP - WARNING - $mount usage is ${USAGE}%" >> "$LOG_FILE"
			EXIT_CODE=1
		else
			echo "$TIMESTAMP - OK - $mount usage is ${USAGE}%" >> "$LOG_FILE"
		fi

	done

exit ${EXIT_CODE:-0}

#${VAR:-DEFAULT} is a Bash parameter expansion used to provide a fallback value if the variable is unset or empty.
#It is commonly used with exit to ensure scripts return a valid exit status.
