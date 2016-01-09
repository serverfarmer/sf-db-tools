#!/bin/sh

if [ "$3" = "" ]; then
	echo "usage: $0 <new-database> <new-login> <new-password>"
	exit 1
fi

db=$1
user=$2
pass=$3

echo "create user $user with password '$pass';" |sudo -u postgres psql -q
echo "create database $db with owner $user;" |sudo -u postgres psql -q
