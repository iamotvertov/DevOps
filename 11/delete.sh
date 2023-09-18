#!/bin/bash

date=$(date "+%Y_%m_%d_%H_%M_%S")
path=$HOME/TRASH
back_up=$HOME/TRASH/backup-"$date.tar.gz"
original_name=$(readlink $1)
number_inode=$(stat $1 | grep Inode | awk -F " " '{print $4}')
count_links_inode=$(stat $1 | grep Inode | awk -F " " '{print $6}')



if [ $# -ne 1 ]
then
        echo "You need only one agrument for running script"
        exit 1
fi

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

if [ -h $1 ]
then	
	echo "It was a symbol link and it was removed successfully"
	echo "The original name of $1 is $original_name"
	rm -rf $1
	exit 0

elif [ $count_links_inode -ne 1 ]
then
	echo "It was a hardlink and it was removed successfully"
	rm -rf $1
	echo "List of hardlinks: "
	find ./ -inum $number_inode
	exit 0
else 
        if tar -czPf $back_up $1
	then
		echo "Archiving is successful"
		rm -f $1
		exit 0
	else
		echo "Something went wrong"
	exit 1
	fi
fi
