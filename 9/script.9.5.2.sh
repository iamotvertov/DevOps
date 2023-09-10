#!/bin/bash

date=$(date "+%Y_%m_%d_%H_%M_%S")
path=$HOME/TRASH
back_up=$HOME/TRASH/backup-"$date.tar.gz"

#check count of arg
if [ $# -ne 1 ]
then
        echo "You need only one agrument for running script"
        exit 1
fi

#check path to archive
if [ ! -d $path ]
then
	echo "Path does not exist"
	exit 1
else
	if find $path/ -depth -not -path "$path/" -type d,f -mmin +50 -exec rm -rf {} \; #"-depth depth of searching " -not -path "$path/"" except dir of searching
	then
		echo "All files and directories created more than N-time had been removed"
	else
		echo "During removing something went wrong"
		exit 1
	fi	
fi

#archiving
if tar -czPf $back_up $1
then
	echo "Archiving is successful"
	rm -f $1
	exit 0
else
	echo "Something went wrong"
	exit 1
fi
