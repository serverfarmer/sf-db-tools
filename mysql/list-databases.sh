#!/bin/sh
. /opt/farm/ext/db-utils/functions.mysql

user=`mysql_local_user`

if [ "$user" != "" ]; then
	pass=`mysql_local_password`
	warn="Using a password"
	echo "show databases;" |mysql -u $user -p$pass 2>&1 |egrep -v "^(Database|mysql|test|information_schema|performance_schema)$" |grep -v "$warn"
fi
