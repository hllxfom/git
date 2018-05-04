#!/bin/bash
basepath=$(cd `dirname $0`; pwd)
[ ! -f $basepath/logs ] && touch ${basepath}/logs
logfile=$basepath/logs
echo -e "\n">>${logfile}
echo -e "*************************** `date '+%F %T'` start backup***************************">>${logfile}

game_host=rds6b3um3fynfev.mysql.rds.aliyuncs.com
game_user=wolfplus
game_pass=wsioftwejfsx
#log_host=rdsb3a3meb3a3me.mysql.rds.aliyuncs.com
#log_user=jxing
#log_pass=yxcpvamhyqw
log_host=rr-bp1689045jd9ka305.mysql.rds.aliyuncs.com
log_user=mb_panchengjian
log_pass=Pcj123456

game_db_lobbyv2_tables="tb_pactgame_club tb_pactgame_club_grant tb_pactgame_club_member"
game_db_statistics_tables="tb_platform tb_platform_configure tb_platform_package"
game_db_mobile_tables="tb_match_signup_record tb_match_user_rank_record tb_match_base_cfg tb_match_repeat_cfg tb_phone_personal_match_award_record"

log_db_lobbylog_tables="tb_pactgame_club_grant_log"

for a in $game_db_statistics_tables
do
    mysqldump -h$game_host -u$game_user -p$game_pass  --opt  --default-character-set=utf8 --hex-blob   --single-transaction db_statistics $a >$basepath/$a.sql
done

for b in $game_db_lobbyv2_tables
do
    mysqldump -h$game_host -u$game_user -p$game_pass  --opt  --default-character-set=utf8 --hex-blob   --single-transaction db_lobbyv2 $b  > $basepath/$b.sql
done

for c in $game_db_mobile_tables
do
    mysqldump -h$game_host -u$game_user -p$game_pass  --opt  --default-character-set=utf8 --hex-blob   --single-transaction db_mobile $c > $basepath/$c.sql
done

for d in $log_db_lobbylog_tables
do
    mysqldump -h$log_host -u$log_user -p$log_pass  --opt  --default-character-set=utf8 --hex-blob  --single-transaction db_lobbylog $d > $d.sql
done

for i in `ls $basepath/*.sql`
do
mysql -h218.78.214.153 -uwolfplus -p"s&h.fdaFDp%#23h%x09t%y=" db_lobbyv2 < $i
#echo $i
done

echo -e "*************************** `date '+%F %T'` backup done***************************">>${logfile}
