#!/usr/bin/env bash
for chef_ubuntu_cookbook in essentials fish nginx postgresql ruby-brightbox ruby-install node imagemagick sqlite3 redis-server ufw php5 mysql
do
  ./get-chef-ubuntu-cookbook.sh $chef_ubuntu_cookbook
done
./get-chef-wordpress-development-cookbook.sh
