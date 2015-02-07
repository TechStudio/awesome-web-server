#!/usr/bin/env bash
rm -rf cookbooks/chef-wordpress-development
wget https://github.com/ryanburnette/chef-wordpress-development/tarball/master
tar zxf master
mv ryanburnette-chef-wordpress-development*/ cookbooks/wordpress-development/
rm master
