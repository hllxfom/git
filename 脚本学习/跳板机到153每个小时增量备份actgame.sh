date=`date -d "-1 hours" +"%Y-%m-%d %H:00:00"`
date1=`date +"%Y-%m-%d %H:00:00"`
sql="record_time between '$date' and '$date1'"
dir=/home/wolfplus
mysqldump -hrr-bp1689045jd9ka305.mysql.rds.aliyuncs.com -ujxing -pyxcpvamhyqw  --skip-extended-insert --complete-insert --no-create-info db_lobbylog tb_pactgame_log --where="$sql" >${dir}/tb_pactgame_log_ll.sql
cd $dir
#tar zcvf tb_loginlog_${date}.tar.gz tb_loginlog_${date}.sql
#scp -P 44405 $dir/tb_loginlog_$date.tar.gz 218.78.214.153:/home/wolfplus/
#sleep 5
#rm $dir/tb_loginlog_${date}.tar.gz tb_loginlog_${date}.sql
mysql -h218.78.214.153 -uwolfplus -p"s&h.fdaFDp%#23h%x09t%y=" db_lobbylog < /home/wolfplus/tb_pactgame_log_ll.sql
sleep 2
rm tb_pactgame_log_ll.sql
