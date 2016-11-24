#!/bin/sh

if [ ! -f /etc/mysql/debian.cnf ] || [ ! -f /var/run/mysqld/mysqld.pid ]; then
	exit 0
fi

rootpass="`cat /etc/mysql/debian.cnf |grep password |tail -n1 |sed s/password\ =\ //g`"
access="-u debian-sys-maint -p$rootpass"

mysql $access $@
