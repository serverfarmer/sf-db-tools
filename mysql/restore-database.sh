#!/bin/sh

DROP=0
if [ "$1" = "--drop" ]; then
	shift
	DROP=1
fi

if [ "$4" = "" ]; then
	echo "usage: $0 <file> <db> <login> <password>"
	exit 1
fi

file=$1
db=$2
user=$3
pass=$4

if [ $DROP = 1 ]; then
	echo "drop database $db;" |mysql -u $user -p$pass
	echo "create database $db;" |mysql -u $user -p$pass
fi

cat $file |mysql -u $user -p$pass $db
