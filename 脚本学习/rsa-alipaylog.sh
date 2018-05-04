i=`find ./ -iname rsa.properties`
for a in $i
do
perl -i -pe "s|lele|`echo $a|cut -d'/' -f5`|g" $a
done
