#!/bin/sh

/opt/farm/scripts/setup/extension.sh sf-db-utils
/opt/farm/scripts/setup/extension.sh sf-net-utils

ln -sf /opt/farm/ext/db-tools/mysql/console.sh /usr/local/bin/sf-mysql
ln -sf /opt/farm/ext/db-tools/postgres/console.sh /usr/local/bin/sf-pgsql
