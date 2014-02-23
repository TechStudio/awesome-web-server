# remove listen lines from vsftpd.conf
sed -i.old "/listen=/d" /etc/vsftpd.conf
sed -i.old "/listen_address/d" /etc/vsftpd.conf

# add localhost-only entries
echo "listen=YES" >> /etc/vsftpd.conf
echo "listen_address=127.0.0.1" >> /etc/vsftpd.conf

# restart
service vsftpd restart
