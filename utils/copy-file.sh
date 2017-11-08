#!/bin/bash
. /opt/farm/scripts/functions.custom
. /opt/farm/scripts/functions.keys
# copy given file between 2 remote hosts


COMPRESS=0
if [ "$1" = "--compress" ]; then
	COMPRESS=1
	shift
fi

REMOVE=0
if [ "$1" = "--remove-source-file" ]; then
	REMOVE=1
	shift
fi

if [ "$3" = "" ]; then
	echo "usage: $0 [--compress] [--remove-source-file] <source-host> <target-host> <file> [target-path]"
	exit 1
fi

srchost=$1
dsthost=$2
file=$3
base=`basename $file`

if [ "$4" != "" ]; then
	path=$4
else
	path=`dirname $file`
fi

srckey=`ssh_dedicated_key_storage_filename $srchost root`
dstkey=`ssh_dedicated_key_storage_filename $dsthost root`

if [ $COMPRESS = 1 ]; then
	ssh -i $srckey root@$srchost /bin/gzip -9 $file
	scp -i $srckey -B -p root@$srchost:$file.gz /tmp
	scp -i $dstkey -B -p /tmp/$base.gz root@$dsthost:$path
	ssh -i $dstkey root@$dsthost /bin/gzip -d $path/$base.gz
	if [ $REMOVE = 1 ]; then
		ssh -i $srckey root@$srchost /bin/rm -f $file.gz
	fi
else
	scp -i $srckey -B -p root@$srchost:$file /tmp
	scp -i $dstkey -B -p /tmp/$base root@$dsthost:$path
	if [ $REMOVE = 1 ]; then
		ssh -i $srckey root@$srchost /bin/rm -f $file
	fi
fi
