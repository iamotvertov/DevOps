if [ -h $1 ]
then
	cp $1 filename-backup
	rm $1
	mv filename-backup $1
else
	echo "File does not exist or it is not a file"
	exit 1
fi
