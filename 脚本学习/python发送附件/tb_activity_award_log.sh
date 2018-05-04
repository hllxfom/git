#!/bin/bash
basepath=$(cd `dirname $0`; pwd)
date1=`date +%Y%m%d`
mail=/home/wolfplus/scripts/mail.py
#mail_to="348283738@qq.com"
mail_to="2285@microbeam.cn,315494619@qq.com"

 mysql -h rdsb3a3meb3a3me.mysql.rds.aliyuncs.com  -ujxing -pyxcpvamhyqw  db_lobbylog -e "select * from tb_activity_award_log">${basepath}/${date1}_tb_activity_award_log.txt

python ${mail} "${mail_to}" "${date1}_tb_activity_award_log"  "${date1}_tb_activity_award_log" "${basepath}/${date1}_tb_activity_award_log.txt"

/bin/rm ${basepath}/${date1}_tb_activity_award_log.txt
