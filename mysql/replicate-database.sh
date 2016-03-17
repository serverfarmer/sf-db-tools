#!/bin/bash
. /opt/farm/scripts/functions.custom
# replicate mysql database from one server to another
# both remote servers need to have ssh management keys installed


CREATE=0
if [ "$1" = "--create" ]; then
	CREATE=1
	shift
fi

DROP=0
if [ "$1" = "--drop" ]; then
	DROP=1
	shift
fi

ARCH=""
if [ "$1" = "--archive" ]; then
	ARCH=$2
	shift
	shift
fi

if [ "$5" = "" ]; then
	echo "usage: $0 [--create] [--drop] [--archive file] <source-host> <target-host> <db> <login> <password> [target-password]"
	exit 1
fi

srchost=$1
dsthost=$2
db=$3
user=$4
srcpass=$5

if [ "$6" != "" ]; then
	dstpass=$6
else
	dstpass=$5
fi

path="/opt/farm/ext/db-tools/mysql"
file="/tmp/replicate.$RANDOM.sql"

srckey=`ssh_dedicated_key_storage_filename $srchost root`
dstkey=`ssh_dedicated_key_storage_filename $dsthost root`

echo "dumping source database"
ssh -i $srckey root@$srchost $path/dump-database.sh $file $db $user $srcpass

echo "compressing dump file and preparing to transfer it from source to target host"
/opt/farm/ext/db-tools/utils/copy-file.sh --compress --remove-source-file $srchost $dsthost $file

if [ $CREATE = 1 ]; then
	echo "creating target database and user"
	ssh -i $dstkey root@$dsthost $path/create-database-and-user.sh $db $user $dstpass
	echo "restoring target database from dump file"
	ssh -i $dstkey root@$dsthost $path/restore-database.sh $file $db $user $dstpass
elif [ $DROP = 1 ]; then
	echo "restoring target database from dump file (with drop & create)"
	ssh -i $dstkey root@$dsthost $path/restore-database.sh --drop $file $db $user $dstpass
else
	echo "restoring target database from dump file"
	ssh -i $dstkey root@$dsthost $path/restore-database.sh $file $db $user $dstpass
fi

echo "removing dump file from target host"
ssh -i $dstkey root@$dsthost /bin/rm -f $file

if [ $ARCH != "" ]; then
	echo "archiving dump file as $ARCH"
	mv $file.gz $ARCH
else
	echo "removing dump file from local host"
	rm -f $file.gz
fi
