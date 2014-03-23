execute "install_nginx_prereqs" do
  command "apt-get install -y -q python-software-properties software-properties-common"
  user "root"
  action :run
end

execute "add_nginx_apt_repository" do
  command "add-apt-repository ppa:nginx/stable;apt-get update"
  user "root"
  action :run
  not_if "test -f #{Chef::Config[:file_cache_path]}/nginx_lock"
end

apt_package "nginx" do
  action :upgrade
end

template "/etc/nginx/nginx.conf" do
  source "nginx.conf.erb"
  mode 0770
  owner "root"
  group "adm"
  not_if "test -f #{Chef::Config[:file_cache_path]}/nginx_lock"
end

#install htpasswd.py for generating htpasswd files w/out apacheutils installed
template "/usr/local/bin/htpasswd.py" do
  source "htpasswd.py"
  mode 0770
  owner "root"
  group "adm"
  not_if "test -f #{Chef::Config[:file_cache_path]}/nginx_lock"
end

file "#{Chef::Config[:file_cache_path]}/nginx_lock" do
  owner "root"
  group "root"
  mode "0755"
  action :touch
end

service "nginx" do
  supports :restart => true, :start => true, :stop => true, :reload => true
  action [:enable,:start]
end

# add templates to sites-available
