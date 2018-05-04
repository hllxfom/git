#!/bin/bash
read -p "input change filepath: " filepath1
read -p "input zippath: " zippath
read -p "input logtime [example 01-01]: " datetime
read -p "input zip's name: " zipname


if [ -d ${filepath1} ];then
        cd ${filepath1}
        echo "change directory success"
else
        echo "no such directory"
        exit 1
fi

count=$(find ${zippath} -type f -name "${datetime}*.log" | wc -l )


if [ $count -le 0 ];then
        echo "the file what you find is unavailable"
        exit 2
else
        find ${zippath} -type f -name "${datetime}*.log"  | xargs tar -zcvf ${zipname}.tgz 
        echo "collect success,find tar file in /home/wolfplus/${zipname}.tgz"
        mv ${filepath1}/${zipname}.tgz ~/
fi
