Date1=`date -d "-4 days" +"%Y-%m-%d 00:00:00"`
Date2=`date -d "-4 days" +"%Y-%m-%d 23:59:59"`
sql="record_time between '$Date1' and '$Date2'"

mysqldump -hrr-bp1689045jd9ka305.mysql.rds.aliyuncs.com -ujxing -pyxcpvamhyqw --skip-extended-insert --complete-insert --no-create-info db_lobbylog tb_shoplog_roomcard --where="$sql" >/tmp/daily-db_lobbylog_tb_shoplog_roomcard.sql

#mysqldump -hrr-bp1689045jd9ka305.mysql.rds.aliyuncs.com -ujxing -pyxcpvamhyqw db_lobbylog tb_shoplog_roomcard --where="$sql">/tmp/daily-db_lobbylog_tb_shoplog_roomcard.sql
#tar zcvf tb_loginlog_${date}.tar.gz tb_loginlog_${date}.sql
#scp -P 44405 $dir/tb_loginlog_$date.tar.gz 218.78.214.153:/home/wolfplus/
#sleep 5
#rm $dir/tb_loginlog_${date}.tar.gz tb_loginlog_${date}.sql
mysql -h218.78.214.153 -uwolfplus -p"s&h.fdaFDp%#23h%x09t%y=" db_lobbylog < /tmp/daily-db_lobbylog_tb_shoplog_roomcard.sql
