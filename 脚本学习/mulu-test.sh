#!/bin/bash
#day=$(date +%m-%d -d '2 days ago')
diskspace=$(df -h | tail -1 | awk '{print $5}' | grep -o "[0-9]*")

if [ $diskspace -gt 30 ]
then
        for i in $(seq 1 20 | sort -nr)
        do
                day=$(date +%m-%d -d "$i days ago")
                count=$(find /home/wolfplus/sbin/mobilegame/ -name $day*.log | wc -l)
                if [ $count -gt 2 ]
                then
                #find /home/wolfplus/ -name $day*.log | xargs rm -f
                echo "delete $day"
                break
                fi
        done

else
        echo "space is enough"

fi

