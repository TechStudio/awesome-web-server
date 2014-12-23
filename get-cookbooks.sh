wget https://github.com/chef-ubuntu/nginx/tarball/master
tar zxf master
mv chef-ubuntu-nginx* cookbooks/nginx
rm master

wget https://github.com/chef-ubuntu/postgresql/tarball/master
tar zxf master
mv chef-ubuntu-postgr* cookbooks/postgres
rm master

wget https://github.com/chef-ubuntu/ruby/tarball/master
tar zxf master
mv chef-ubuntu-ruby* cookbooks/ruby
rm master

wget https://github.com/chef-ubuntu/node/tarball/master
tar zxf master
mv chef-ubuntu-node* cookbooks/node
rm master

wget https://github.com/chef-ubuntu/imagemagick/tarball/master
tar zxf master
mv chef-ubuntu-imagemagick* cookbooks/imagemagick
rm master
