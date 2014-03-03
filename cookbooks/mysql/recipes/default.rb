bash "mysql_initial_install" do
  code <<-EOH
    export DEBIAN_FRONTEND=noninteractive
    apt-get -q -y install mysql-server
  EOH
  user "root"
  not_if "test -f #{Chef::Config[:file_cache_path]}/mysql_lock"
end

apt_package "mysql-server" do
  action :upgrade
  only_if "test -f #{Chef::Config[:file_cache_path]}/mysql_lock"
end

file "#{Chef::Config[:file_cache_path]}/mysql_lock" do
  owner "root"
  group "root"
  mode "0755"
  action :touch
end

mysql_initial = data_bag_item("mysql", "initial")
password = mysql_initial["root_password"]

bash "mysql_initial_config" do
  code <<-EOH
    mysqladmin -u root password #{password}
    echo "grant all privileges on *.* to 'root'@'%' identified by '#{password}'; FLUSH PRIVILEGES;" | mysql -u root -p#{password}
  EOH
  user "root"
  not_if "test -f #{Chef::Config[:file_cache_path]}/mysql_intial_config_lock"
end 

file "#{Chef::Config[:file_cache_path]}/mysql_intial_config_lock" do
  owner "root"
  group "root"
  mode "0755"
  action :touch
end
