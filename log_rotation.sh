#!/bin/bash

echo "Size of /var/log/app.log"
SIZE=$(stat -c %s /var/log/app.log)
echo $SIZE

if [ "$SIZE" -gt 1073741824 ];
then
	



