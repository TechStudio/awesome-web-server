execute "install_nginx" do
  command "nginx=stable;add-apt-repository ppa:nginx/$nginx;apt-get update"
  user "root"
  action :run
  #not_if do ! File.exists?("/tmp/nginx_lock") end
  not_if {File.exists?("#{Chef::Config[:file_cache_path]}/nginx_lock")}
end

package "nginx-full" do
  action :install
end

"""
execute "remove-sites-enabled" do
  command "rm /etc/nginx/sites-enabled/*"
  user "root"
  action :run
  only_if {File.exists?("/etc/nginx/sites-available/default")}
end
"""

service "nginx" do
  supports :restart => true, :start => true, :stop => true, :reload => true
  action [:enable,:start]
end

file "#{Chef::Config[:file_cache_path]}/nginx_lock" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end
