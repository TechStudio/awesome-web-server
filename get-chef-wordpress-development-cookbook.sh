#!/usr/bin/env bash
rm -rf cookbooks/chef-wordpress-development
wget https://github.com/ryanburnette/chef-wordpress-development/tarball/master
tar zxf master
mv ryanburnette-chef-wordpress*/ cookbooks/chef-wordpress-development/
rm master
rsync -av cookbooks/chef-wordpress-development/data_bags/ data_bags/
