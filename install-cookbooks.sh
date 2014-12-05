wget https://github.com/chef-ubuntu/nginx/tarball/master
tar -zxf master
mv chef-ubuntu-nginx* cookbooks/nginx
rm master
