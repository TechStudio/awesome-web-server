#!/usr/bin/env bash
for chef_ubuntu_cookbook in essentials fish nginx postgresql ruby-brightbox ruby-install node imagemagick sqlite3 redis-server
do
  ./get-chef-ubuntu-cookbook.sh $chef_ubuntu_cookbook
done
