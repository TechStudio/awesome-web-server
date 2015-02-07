#!/usr/bin/env bash
rm -rf cookbooks/permissions
wget https://github.com/ryanburnette/chef-permissions/tarball/master
tar zxf master
mv ryanburnette-chef-permissions*/ cookbooks/permissions/
rm master
