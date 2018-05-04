#!/bin/bash
bakpath=/home/wolfplus/backup
if [ ! -d $bakpath ];then
  mkdir ${bakpath}
fi

function find_a_platform()
{
for k in `ps x|grep "\<a_platform\>"|grep -v grep|awk '{print $5}'`
  do
   #echo $i
   dir=$(dirname $k)
   pidname=$(basename $k)
   noname=`echo ${pidname} | /bin/sed 's:[0-9]*$::'`
   for j in `find  $dir -name "${noname}*" ! -name $pidname ! -name "${pidname}.symbol" ! -iname "${noname}_log" ! -iname "${noname}.xml"`
     do
       if [ ! -x ${j} ];then
        # echo  $j
            namepath=$(echo $j|awk -F / '{print $5"/"$6"/"$7}')
            if [ ! -d ${bakpath}/${namepath} ];then
            echo ${bakpath}/${namepath}
           fi
          echo mv $j ${bakpath}/${namepath}/
       fi
   done
  
  done
}

function find_platform_xml()
{
for t in `find /home/wolfplus/sbin/mobilegame/a_platform/ -iname "*.xml-*" -o -iname "*.xml_*"`
   do
     namepath=$(echo $t|awk -F / '{print $5"/"$6"/"$7}')
     if [ ! -d ${bakpath}/${namepath} ];then
       echo ${bakpath}/${namepath}
     fi
    echo mv $t ${bakpath}/${namepath}/
  done
}

function find_game_xml()
{
for i in `find /home/wolfplus/sbin/mobilegame/game -iname "*.xml-*-*" -o -iname "*.xml_*"`
   do
     namepath=$(echo $i|awk -F / '{print $5"/"$6"/"$7"/"$8"/"$9}')
     #if [ ! -d ${bakpath}/${namepath} ];then
      # echo ${bakpath}/${namepath}
     #fi
    echo mv $i ${bakpath}/${namepath}/
  done
}

function find_game()
{
for k in ` ps x|grep "/home/wolfplus/sbin/mobilegame/game"|grep -v grep|awk '{print $5}'`
  do
   #echo $i
   dir=$(dirname $k)
   pidname=$(basename $k)
   noname=`echo ${pidname} | /bin/sed 's:[0-9]*$::'`
   for j in `find  $dir -name "${noname}*" ! -name $pidname ! -name "${pidname}.symbol" ! -iname "${noname}_log" ! -iname "${noname}.xml"`
     do
       if [ ! -x ${j} -a "$(dirname $j)" != "${pidname}*" ];then
        # echo  $j
            namepath=$(echo $j|awk -F / '{print $5"/"$6"/"$7"/"$8"/"$9}')
            if [ ! -d ${bakpath}/${namepath} ];then
            echo mkdir -p ${bakpath}/${namepath} >>/tmp/yan
           fi
          echo mv $j ${bakpath}/${namepath}/ >>/tmp/yan
       fi
   done
  done
}


function check_game()
{
#check game server exists
for d in `ps x|grep "\<game\>"|grep -v grep|awk '{print $5}'`
   do
     if [ ! -e $d -a ! -x $d  ];then
        echo $d not exist
     fi
     if [ ! -e ${d}.symbol ];then
       echo ${d}.symbol not exist
     fi
   done
}

function check_a_platform()
{
for d in `ps x|grep "\<a_platform\>"|grep -v grep|awk '{print $5}'`
   do
     if [ ! -e $d -a ! -x $d  ];then
        echo $d not exist
     fi
     if [ ! -e ${d}.symbol ];then
       echo ${d}.symbol not exist
     fi
   done
}
find_game
#check_game
#check_a_platform
