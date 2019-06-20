#!/bin/sh
. /opt/farm/ext/db-utils/functions.mysql

if [ "$2" = "" ]; then
	echo "usage: $0 <file> <db>"
	exit 1
fi

file=$1
db=$2
user=`mysql_local_user`

if [ "$user" != "" ]; then
	pass=`mysql_local_password`
	mysqldump --skip-lock-tables -u $user -p$pass $db >$file
else
	echo "error: mysql-server credentials cannot be discovered"
	exit 1
fi
