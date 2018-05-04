#!/bin/bash
echo -n "Please input your want get majiang log (example:bymj) :"  
read  majiang
echo -n "Please input room  (example:srf):"
read room
echo -n "Please input month:"
read  month
echo -n "Please input day:"
read  day
[ $month -lt 10 ] && month=0$month
[ $day -lt 10 ] && day=0$day
log=/tmp/log
[ ! -d /tmp/log ] && mkdir -p ${log}
log_dir=/home/wolfplus/sbin/mobilegame/game/${majiang}/${room}/
 if [ -d ${log_dir} ] ;then
    for i in `find ${log_dir} -name "${month}-${day}*"`
       do
          name=$(echo $i|awk -F / '{print $7"_"$8"_"$9"_"$10"_"$12}')
          cp -a $i ${log}/$name >/dev/null 2>&1
   done
   cd $log
    tar zcf ${majiang}_${room}_${month}_${day}_log.tar.gz $majiang*
   [ $? -eq 0 ] && sz ${log}/${majiang}_${room}_${month}_${day}_log.tar.gz && rm ${log}/${majiang}*
  else
   echo -e "\033[31m ${log_dir} dir not exist \033[0m \n please check $majiang capital" 
 fi
