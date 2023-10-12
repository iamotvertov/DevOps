#!/bin/bash

path_to_save_db=/home/pascha/DevOps/15/backups
time_created=$(date +%d_%m_%Y-%H_%M_%S)
full_name="$path_to_save_db"/mysql_backup_"$time_created".sql.lzma
db_name="OMGTU"
db_user="backup"
db_pass="12345"

if [  ! -d $path_to_save_db ]
then
	echo "Path to save db does not exist"
	exit 1
fi


if systemctl status mysql.service &>/dev/null
then 
	sudo mysqldump -u $db_user -p$db_pass $db_name | lzma > $full_name #another option              systemctl is-active --quiet mysql || exit 1
	find $path_to_save_db -type f -mtime +7 -delete
else	
	echo "MySQL-Server does not run"
	exit 1
fi
