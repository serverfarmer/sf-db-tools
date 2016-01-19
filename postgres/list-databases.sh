#!/bin/sh

sudo -u postgres psql -l -q 2>/dev/null |awk "{ print \$1 }" |grep ^[a-zA-Z] |grep -v ^template[0-9]$ |egrep -v "^(List|Name|postgres)$"
