#!/bin/bash

#this is a script that will tell us whether nginx service is active or inactive


# is-active tells us about the state
#we dont want any output so we put it in /dev/null
#now 1 refers to normal out and 2 refers to error output
# 2>$1 sends the  error output at the same place as normal output
# so error output also goes to /dev/null


systemctl is-active nginx > /dev/null 2>$1

#$? checks the output of the last executed command
#if it was 0 -> true
#if 1 or more than 1 -> false

if [ $? -eq 0 ];
then 
	echo "NGINX OK"
else
	echo "NGINX DOWN"

fi


