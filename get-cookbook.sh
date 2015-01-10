#!/usr/bin/env bash
rm -rf cookbooks/$1
wget https://github.com/chef-ubuntu/$1/tarball/master
tar zxf master
mv chef-ubuntu-$1* cookbooks/$1
rm master
