#!/bin/bash
logname=11-13.log
path=/home/wolfplus/sbin/mobilegame/robot/TGMJ_HAND
logtype=RobotPlus_log


cd $path
for var in `ls -d */ | grep -o "[^/]*"`
do
	for file in `find  $path/$var/$logtype  -name $logname`
	do	
	a=`dirname $file`	
	b=`basename $file`
	cd $a
	tar -zcvf /home/wolfplus/$logname.$logtype.$var.tgz $b
	done
done
