date=`date -d "-1 days" +"%Y%m%d"`
dir=/home/wolfplus
mysqldump -hrr-bp1689045jd9ka305.mysql.rds.aliyuncs.com -ujxing -pyxcpvamhyqw db_lobbylog tb_playerlog_${date} >${dir}\tb_playerlog_${date}.sql
cd $dir
tar zcvf tb_playerlog_${date}.tar.gz tb_playerlog_${date}.sql
scp -P 44405 /home/tb_playerlog_${date}.tar.gz 218.78.214.153:/home/wolfplus/
sleep 5
rm $dir/tb_playerlog_${date}.tar.gz
