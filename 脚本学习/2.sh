#!/bin/bash 
cd /home/wolfplus/sbin/mobilegame
for i in `find ./a_platform -name *.xml`
do
grep -H  $i >> test
done
