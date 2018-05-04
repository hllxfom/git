for i in `find /home/wolfplus/backup-for-mobilegame -maxdepth 1 -type d`
do
	cd $i
	for file in `ls|grep -Po "[0-9]{4,}-[0-9]{2}-[0-9]{2}-*.*\.tar.gz"`
		do   
			year=${file:0:4}
			month=${file:5:2}

			#file_date=`grep -Po "(?<=-[0-9]{2}-)[0-9]{2}"<<<$file`
			[ -d $year ] || mkdir $year

			[ -d $year/$month ] || mkdir $year/$month
			mv $file $year/$month
		done
	cd /home/wolfplus/backup-for-mobilegame
done
