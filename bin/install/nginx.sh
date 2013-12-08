# install
apt-get install nginx

# restart
service nginx restart

# test listen address
ifconfig eth0 | grep inet | awk '{ print $2 }'

# ensure restart
update-rc.d nginx defaults
