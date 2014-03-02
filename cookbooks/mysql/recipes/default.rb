bash "mysql_initial_install" do
  code <<-EOH
    export DEBIAN_FRONTEND=noninteractive
    apt-get -q -y install mysql-server
  EOH
  user "root"
  not_if "test -f #{Chef::Config[:file_cache_path]}/mysql_lock"
end

package "mysql-server" do
  action :upgrade
  only_if "test -f #{Chef::Config[:file_cache_path]}/mysql_lock"
end

file "#{Chef::Config[:file_cache_path]}/mysql_lock" do
  owner "root"
  group "root"
  mode "0755"
  action :touch
end
