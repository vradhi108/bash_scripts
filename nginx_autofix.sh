#!/bin/bash

systemctl is-active nginx > /dev/null 2>&1
STATUS=$? 

#this we do because $? stores the output of last executed command
# if we put it in if block, then the last executed output is timestamp
# so we store the output in STATUS before executing the timestamp

TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")
if [ $STATUS -ne 0  ]; then
	systemctl start nginx
	echo "$TIMESTAMP - Nginx was down, restarted" >> nginx.log
fi
  
