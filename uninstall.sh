#!/bin/sh

if [ -h /usr/local/bin/sf-mysql ]; then
	rm -f /usr/local/bin/sf-mysql
fi

if [ -h /usr/local/bin/sf-pgsql ]; then
	rm -f /usr/local/bin/sf-pgsql
fi
