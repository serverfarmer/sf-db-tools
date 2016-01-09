#!/bin/sh

if [ "$4" = "" ]; then
	echo "usage: $0 <file> <db> <login> <password>"
	exit 1
fi

file=$1
db=$2
user=$3
pass=$4

mysqldump --skip-lock-tables -u $user -p$pass $db >$file
