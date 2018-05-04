#!/bin/bash
datetime=$(date "+%Y%m%d_%H:%M")

for acfile in com_banding_web_net_tcpLibrary.jar
do
list1=`find /home/web/front/pzmjf/WEB-INF/lib -name "$acfile" 2> /dev/null`
        for acfile1 in $list1
        do
        diff /home/wolfplus/bin/zyscript/$acfile $acfile1>/dev/null
        if [ $? -eq 0 ];then
                echo "already new file for $acfile1"
                elif [ -f /home/wolfplus/bin/zyscript/$acfile ];then
                        mv $acfile1 $acfile1-xy-$datetime
                        cp /home/wolfplus/bin/zyscript/$acfile $acfile1
                        if [ $? -eq 0 ];then

                        echo "$acfile update success in $acfile1"
                        else
                        echo "$acfile update faild in $acfile1"
                        fi
                else
                        echo "$acfile does not exists..."
        fi
        done
done

