#!/bin/bash

#check count of arguments
if [ $# -ne 1 ]
then
	echo "You need only one agrument to run script! "
	exit 1
fi

if [ ! -f $! ]
then
	echo "File does not exist or it is not the file! "
	exit 1
fi

if dpkg -l unzip &>/dev/null
then
	echo "Unzip is installed"
else
	echo "Unzip is not installed"
fi

case $1 in 
	*.bz2) bunzip2 $1 ;;
	*.gz) gunzip $1 ;;
	*.zip) unzip $1 ;;
	*.lzma) unlzma $1 ;;
	*) echo "This format does not support"
esac
