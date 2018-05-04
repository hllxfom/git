#!/bin/bash
Date=`date '-d -1 day' +%Y%m%d`
Date1=`date '-d -1 day' +%Y-%m-%d`
Date2=`date '-d -30 day' +%Y%m%d`
Date3=`date +%Y-%m-%d`
Date4=`date '-d -1 day' +%Y-%m-%d`
datetime1=$(date -d "$Date3" +%s)
datetime2=$(date -d "$Date4" +%s)
Name1=tb_wj_commodity_log_$Date
Name2=tb_wj_player_log_$Date
Name3=tb_playerlog_$Date
Name4=tb_account_$Date
LANG=en
mail=/home/wolfplus/scripts/mail.py
mail_to="guwei@microbeam.cn"

mysql -hrds6b3um3fynfev.mysql.rds.aliyuncs.com -uwolfplus -pwsioftwejfsx db_mobile_nnlog -e "select * from $Name1" >/home/wolfplus/bin/wj_data/$Name1.txt
sleep 2
mysql -hrds6b3um3fynfev.mysql.rds.aliyuncs.com -uwolfplus -pwsioftwejfsx db_mobile_nnlog -e "select * from $Name2" >/home/wolfplus/bin/wj_data/$Name2.txt
sleep 2
mysql -hrds6b3um3fynfev.mysql.rds.aliyuncs.com -uwolfplus -pwsioftwejfsx db_validate -e "select * from db_validate.tb_account where a_regtime >= $datetime2 and a_regtime < $datetime1  and a_source in (9100,9001,9200,9102,9003,12001,12100,12200,51001,51100,51200)" >/home/wolfplus/bin/wj_data/$Name4.txt
sleep 2
mysql -hrdsb3a3meb3a3me.mysql.rds.aliyuncs.com -ujxing -pyxcpvamhyqw db_lobbylog -e "select * from $Name3 where pl_gameid in (320,321,322,323,324,192,249,250,251,252,253,339,340,243,248)" >/home/wolfplus/bin/wj_data/$Name3.txt
sleep 2

today=`date +"%Y-%m-%d 00:00:00"`
#today=`date -d "+1 day" +"%Y-%m-%d 00:00:00"`
pid=`tail -1 /home/wolfplus/bin/jhrw/tb_shoplog_roomcard.txt |awk '{print $1}'`
mysql -hrdsb3a3meb3a3me.mysql.rds.aliyuncs.com -ujxing -pyxcpvamhyqw db_lobbylog -e "select * from tb_shoplog_roomcard where record_time LIKE '$Date1%'" >/home/wolfplus/bin/jhrw/tb_shoplog_roomcard.txt
#mysql -hrr-bp1689045jd9ka305.mysql.rds.aliyuncs.com -umb_panchengjian -pPcj123456 db_lobbylog -e "select * from tb_shoplog_roomcard where id > $pid and record_time<'$today'" > /home/wolfplus/bin/jhrw/tb_shoplog_roomcard.txt

cp /home/wolfplus/bin/jhrw/tb_shoplog_roomcard.txt /home/wolfplus/bin/wj_data/tb_shoplog_roomcard.txt


###########
cd /home/wolfplus/bin/wj_data/
tar -zcf wj_$Date.tar.gz ./*.txt

#####
python $mail "$mail_to"  "wj" "wj"  "/home/wolfplus/bin/wj_data/wj_$Date.tar.gz"
#echo "自动发送邮件" | mutt guwei@microbeam.cn -s "wj" -a /home/wolfplus/bin/wj_data/wj_$Date.tar.gz 

#####
rm -f /home/wolfplus/bin/wj_data/*.txt

####
rm -f /home/wolfplus/bin/wj_data/wj_$Date2.tar.gz
