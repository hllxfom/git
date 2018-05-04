for i in {1201..1231}
do
mysqldump -hrr-bp1689045jd9ka305.mysql.rds.aliyuncs.com -ujxing -pyxcpvamhyqw db_lobbylog tb_playerlog_2016${i} >/home/wolfplus/hll-update/system-back/playerlog/tb_playerlog_201612/tb_playerlog_2016${i}.sql
done
