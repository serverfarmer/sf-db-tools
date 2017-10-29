#!/bin/sh

if [ -f /etc/mysql/debian.cnf ] && [ -f /var/run/mysqld/mysqld.pid ]; then
	pass="`cat /etc/mysql/debian.cnf |grep password |tail -n1 |sed s/password\ =\ //g`"
	mysql -u debian-sys-maint -p$pass $@

elif [ -f /usr/local/directadmin/conf/mysql.conf ]; then
	user="`cat /usr/local/directadmin/conf/mysql.conf |grep user= |tail -n1 |sed s/user=//g`"
	pass="`cat /usr/local/directadmin/conf/mysql.conf |grep passwd= |tail -n1 |sed s/passwd=//g`"
	mysql -u $user -p$pass $@
fi
