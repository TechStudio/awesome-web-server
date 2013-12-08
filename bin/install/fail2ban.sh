# install
apt-get install fail2ban

# move config to local
cp /etc/fail2ban/jail.conf /etc/fail2ban/jail.local

# restart
service fail2ban restart
