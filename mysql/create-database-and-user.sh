#!/bin/sh
# create new mysql database and user will full permissions to create/alter/drop tables/views/etc.
# - suitable for development/testing/integration purposes
# - NOT suitable for production purposess, or in case your database holds sensitive data



if [ "$3" = "" ]; then
	echo "usage: $0 <new-database> <new-login> <new-password>"
	exit 1
elif [ ! -f /etc/mysql/debian.cnf ] || [ ! -f /var/run/mysqld/mysqld.pid ]; then
	echo "error: debian-sys-maint password not found"
	exit 1
fi

rootpass="`cat /etc/mysql/debian.cnf |grep password |tail -n1 |sed s/password\ =\ //g`"
access="-u debian-sys-maint -p$rootpass"

db=$1
user=$2
pass=$3

echo "create database $db;" |mysql $access
echo "grant all privileges on $db.* to $user@localhost identified by '$pass';" |mysql $access
echo "flush privileges;" |mysql $access
