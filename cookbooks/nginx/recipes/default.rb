execute "install_nginx_prereqs" do
  command "apt-get install -y -q python-software-properties software-properties-common"
  user "root"
  action :run
end

execute "add_nginx_apt_repository" do
  command "add-apt-repository ppa:nginx/stable;apt-get update"
  user "root"
  action :run
  not_if {File.exists?("#{Chef::Config[:file_cache_path]}/nginx_lock")}
end

package "install_nginx" do
  action :install
end

file "#{Chef::Config[:file_cache_path]}/nginx_lock" do
  owner "root"
  group "root"
  mode "0755"
  action :touch
end

#execute "remove-sites-enabled" do
#  command "rm /etc/nginx/sites-enabled/*"
#  user "root"
#  action :run
#  only_if {File.exists?("/etc/nginx/sites-available/default")}
#end

service "nginx_service" do
  supports :restart => true, :start => true, :stop => true, :reload => true
  action [:enable,:start]
end