dir=/home/wolfplus
adate=`date -d "-1 days" +"%Y-%m-%d %H:00:01"`
bdate=`date  +"%Y-%m-%d %H:00:00"`
timea=`date +%s -d "$adate"`
timeb=`date +%s -d "$bdate"`
sql="a_regtime between $timea and $timeb"

mysqldump -hrds6b3um3fynfev.mysql.rds.aliyuncs.com   -uwolfplus -pwsioftwejfsx  --skip-extended-insert --complete-insert --no-create-info db_validate tb_account --where="$sql" >${dir}/daily-db_validate_tb_account.sql

cd $dir

#tar zcvf tb_loginlog_${date}.tar.gz tb_loginlog_${date}.sql
#scp -P 44405 $dir/tb_loginlog_$date.tar.gz 218.78.214.153:/home/wolfplus/
#sleep 5
#rm $dir/tb_loginlog_${date}.tar.gz tb_loginlog_${date}.sql
mysql -h218.78.214.153 -uwolfplus -p"s&h.fdaFDp%#23h%x09t%y=" db_validate < /home/wolfplus/daily-db_validate_tb_account.sql
sleep 2
rm daily-db_validate_tb_account.sql
