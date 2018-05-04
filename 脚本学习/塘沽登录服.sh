killall -15 PhoneServer2031;sleep 2;killall -9 PhoneServer2031
chmod -x /home/wolfplus/sbin/mobilegame/a_platform/PhoneServer_tgmjnew*/PhoneServer2031
sleep 2
cp -r /home/wolfplus/sbin/mobilegame/a_platform/PhoneServer2031* /home/wolfplus/sbin/mobilegame/a_platform/PhoneServer_tgmjnew1/
cp -r /home/wolfplus/sbin/mobilegame/a_platform/PhoneServer2031* /home/wolfplus/sbin/mobilegame/a_platform/PhoneServer_tgmjnew2/
chmod +x /home/wolfplus/sbin/mobilegame/a_platform/PhoneServer_tgmjnew*/PhoneServer2031
~/starter.sh start
sleep 2
~/starter.sh start
