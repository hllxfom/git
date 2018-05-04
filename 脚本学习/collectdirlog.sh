#!/bin/bash
logname=10-26.log
path=/home/wolfplus/sbin/mobilegame/a_platform/PhoneServer
logtype=DirServer_log


c=`dirname $path`
cd $c
for var in `ls -d */ | grep -o "[^/]*"`
do
	for file in `find  $path*  -name $logname`
	do	
	a=`dirname $file`	
	b=`basename $file`
	cd $a
	tar -zcvf /home/wolfplus/$logname.$logtype.$var.tgz $b
	done
done
