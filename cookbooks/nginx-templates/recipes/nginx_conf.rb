template "/etc/nginx/nginx.conf" do
  source "nginx.conf.erb"
  mode 0644
  owner "root"
  group "adm"
  not_if "test -f #{Chef::Config[:file_cache_path]}/nginx_conf_lock"
end

file "#{Chef::Config[:file_cache_path]}/nginx_conf_lock" do
  owner "root"
  group "root"
  mode "0755"
  action :touch
end
