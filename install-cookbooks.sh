#!/usr/bin/env bash
for chef_ubuntu_cookbook in essentials fish nginx postgresql ruby-brightbox ruby-install node imagemagick sqlite3 redis-server ufw php5 mysql fail2ban
do
  ./get-chef-ubuntu-cookbook.sh $chef_ubuntu_cookbook
done
./get-chef-wordpress-development-cookbook.sh
./get-chef-permissions-cookbook.sh
