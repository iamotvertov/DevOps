#!/bin/bash 

FILENAME=$1
OUTPUT_FILE=$1.edited

if [ $# -ne 1 ]
then
	echo "You need one arg to run script"
	exit 1
fi

sed '1p;/^#/d' $FILENAME > $OUTPUT_FILE
echo "Script $FILENAME without comments is stored in $OUTPUT_FILE"
