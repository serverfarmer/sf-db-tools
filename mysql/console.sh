#!/bin/sh
. /opt/farm/ext/db-utils/functions.mysql

user=`mysql_local_user`

if [ "$user" != "" ]; then
	pass=`mysql_local_password`
	mysql -u $user -p$pass $@
fi
