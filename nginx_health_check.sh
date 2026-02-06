#!/bin/bash

#I used an if condition along with the exit status ($?) to check whether the nginx service is running.
#When I detected that nginx was down, I attempted to start the service using systemctl start.
#I then logged the service status along with a timestamp to track when the action was performed.

SERVICE="nginx"
TIMESTAMP="$(date "+%Y-%m-%d %H:%M:%S")"
LOG_FILE="/var/log/nginx_health.log"

#This command 1. list all the services in the system.
# 2. grep command with -q searches for nginx.service in the result of list-util-files and return exit code 0 or 1. if the exit code is 0, file exists otherwise return 1 which means service doesn't exists in system.

systemctl list-util-files | grep -q "^${SERVICE}.service"
if [ $? -ne 0 ]; then
	echo "$TIMESTAMP - ERROR: $SERVICE NOT FOUND" >> "$LOG_FILE"
	exit 2
fi


systemctl is-active "$SERVICE" > /dev/null 2>&1

if [ $? -ne 0 ]; then
	echo "$TIMESTAMP - SERVICE IS DOWN" >> "$LOG_FILE"
	systemctl start "$SERVICE" > /dev/null 2>&1
	systemctl is-active "$SERVICE" > /dev/null 2>&1

	#I used an if condition along with the exit status ($?) to check whether the nginx service is running.
	#When I detected that nginx was down, I attempted to start the service using systemctl start.
	#I then logged the service status along with a timestamp to track when the action was performed.


	if [ $? -ne 0 ]; then
		echo "$TIMESTAMP - SERVICE FAILED TO START" >> "$LOG_FILE"
		exit 1
	else
		echo "$TIMESTAMP - SERVICE IS ACTIVE NOW" >> "$LOG_FILE"
		exit 0
	fi
else
	echo "$TIMESTAMP - SERVICE IS ACTIVE" >> "$LOG_FILE"
	exit 0
fi

