#!/bin/bash

TIMESTAMP="$(date "+%Y-%m-%d %H:%M:%S")"
LOG_FILE="$WORKSPACE/script.log"
TEST="$WORKSPACE/test.txt"
if [ ! -f "$SCRIPT_NAME" ]; then
	echo "$TIMESTAMP - FILE DOESN'T EXIST " >> "$LOG_FILE"
	exit 2
fi

chmod +x "$SCRIPT_NAME"

echo "$TIMESTAMP - $SCRIPT_NAME EXECUTING...." >> "$LOG_FILE"

./"$SCRIPT_NAME" >> "$TEST"	

STATUS=$?

if [ $STATUS -ne 0 ]; then
	echo "$TIMESTAMP - EXECUTION FAILED" >> "$LOG_FILE"
	exit 1
fi

echo "$TIMESTAMP - EXECUTION SUCCESSFULL" >> "$LOG_FILE"
