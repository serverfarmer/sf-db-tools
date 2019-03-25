#!/bin/sh

DROP=0
if [ "$1" = "--drop" ]; then
	shift
	DROP=1
fi

if [ "$2" = "" ]; then
	echo "usage: $0 [--drop] <file> <db>"
	exit 1
fi

file=$1
db=$2

if [ $DROP = 1 ]; then
	sudo -u postgres pg_dump -c $db >$file
else
	sudo -u postgres pg_dump $db >$file
fi
