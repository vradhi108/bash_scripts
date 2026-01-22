#! /bin/bash

# awk statement - in row 2 print column 5
USAGE=$(df -h / | awk 'NR==2 {print $5}')

#USAGE% -> is syntax % is used to select the back characters
#\ is used to provide the character we want to remove
#% is the character we want to remove

USAGE=${USAGE%\%}
TIMESTAMP=$(date "+%Y-%m-%d %H:%M:%S")

# -ge -> greater than equal to
if [ $USAGE -ge 90 ];then
	echo "$TIMESTAMP - CRITICAL - Disk usage is $USAGE" >> usage.log
elif [ $USAGE -ge 80 ];then
	echo "$TIMESTAMP - WARNING - Disk usage is $USAGE" >> usage.log 
else
	echo "Healthy" >> usage.log
fi

