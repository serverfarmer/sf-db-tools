#!/bin/bash
. /opt/farm/scripts/functions.net
. /opt/farm/ext/db-utils/functions.mysql
# create new mysql database and user will full permissions to create/alter/drop tables/views/etc.
# - suitable for development/testing/integration purposes
# - NOT suitable for production purposess, or in case your database holds sensitive data


if [ "$3" = "" ]; then
	echo "usage: $0 <new-database> <new-login> <new-password> [hostname]"
	exit 1
elif [ "$4" != "" ] && [ "$4" != "%" ] && [ "`resolve_host $4`" = "" ]; then
	echo "error: parameter $4 not conforming hostname format, or given hostname is invalid"
	exit 1
fi

rootuser=`mysql_local_user`
rootpass=`mysql_local_password`

if [ "$rootuser" = "" ]; then
	echo "error: mysql-server credentials cannot be discovered"
	exit 1
fi

access="-u $rootuser -p$rootpass"
warn="Using a password"

db=$1
user=$2
pass=$3

if [ "$4" != "" ]; then
	acl=$4
else
	acl=localhost
fi

echo "create database $db;" |mysql $access 2>&1 |grep -v "$warn"
echo "grant all privileges on $db.* to $user@$acl identified by '$pass';" |mysql $access 2>&1 |grep -v "$warn"
echo "flush privileges;" |mysql $access 2>&1 |grep -v "$warn"
