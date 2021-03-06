template "/etc/logrotate.d/nginx" do
  source "logrotate.erb"
  mode 0770
  owner "root"
  group "adm"
  not_if "test -f #{Chef::Config[:file_cache_path]}/nginx_logrotate_lock"
end

file "#{Chef::Config[:file_cache_path]}/nginx_logrotate_lock" do
  owner "root"
  group "root"
  mode "0755"
  action :touch
end
