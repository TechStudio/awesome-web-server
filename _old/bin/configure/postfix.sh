# remove interface line from main.cf
sed -i.old "/inet_interfaces/d" /etc/postfix/main.cf

# add localhost interface only
echo "inet_interfaces = 127.0.0.1" >> /etc/postfix/main.cf

sleep 1

# restart
service postfix restart
