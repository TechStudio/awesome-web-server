#!/usr/bin/env bash
rm -rf cookbooks/chef-wordpress-development
wget https://github.com/ryanburnette/wordpress-development/tarball/master
tar zxf master
mv ryanburnette-wordpress-development*/ cookbooks/wordpress-development/
rm master
