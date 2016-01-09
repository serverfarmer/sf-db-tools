#!/bin/sh

if [ "$2" = "" ]; then
	echo "usage: $0 <file> <db>"
	exit 1
fi

file=$1
db=$2

cat $file |sudo -u postgres psql -q $db
