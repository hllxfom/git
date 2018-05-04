#!/bin/bash
basepath=$(cd `dirname $0`; pwd)
date1=`date +%Y%m%d -d yesterday`
date2=`date +%Y%m%d`
day1=`date --date=$date1 +%s`
day2=`date --date=$date2 +%s`
mail=/home/wolfplus/scripts/mail.py
#mail_to="348283738@qq.com"
mail_to="1872093912@qq.com"

mysql -hrds6b3um3fynfev.mysql.rds.aliyuncs.com -uwolfplus -pwsioftwejfsx -e "select * from db_lobbyv2.tb_account WHERE a_money<0 and a_lastlogintime>=${day1} and a_lastlogintime<=${day2}" >${basepath}/${date1}_tb_account.txt


if [ `du -sk ${basepath}/${date1}_tb_account.txt|awk '{print $1}'` -gt 0  ];then
    python ${mail} "${mail_to}" "${date1}_tb_account"  "${date1}_tb_account,money <0" "${basepath}/${date1}_tb_account.txt"
    /bin/rm ${basepath}/${date1}_tb_account.txt
else
   /bin/rm ${basepath}/${date1}_tb_account.txt
fi
