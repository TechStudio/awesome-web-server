template "/etc/nginx/sites-available/apache2.conf" do
  source "apache2.conf.erb"
  mode 0644
  owner "root"
  group "adm"
  not_if "test -f #{Chef::Config[:file_cache_path]}/nginx_sites_lock"
end

template "/etc/nginx/sites-available/http_auth.conf" do
  source "http_auth.conf.erb"
  mode 0644
  owner "root"
  group "adm"
  not_if "test -f #{Chef::Config[:file_cache_path]}/nginx_sites_lock"
end

template "/etc/nginx/sites-available/php.conf" do
  source "php.conf.erb"
  mode 0644
  owner "root"
  group "adm"
  not_if "test -f #{Chef::Config[:file_cache_path]}/nginx_sites_lock"
end

template "/etc/nginx/sites-available/redirect.conf" do
  source "redirect.conf.erb"
  mode 0644
  owner "root"
  group "adm"
  not_if "test -f #{Chef::Config[:file_cache_path]}/nginx_sites_lock"
end

template "/etc/nginx/sites-available/static.conf" do
  source "static.conf.erb"
  mode 0644
  owner "root"
  group "adm"
  not_if "test -f #{Chef::Config[:file_cache_path]}/nginx_sites_lock"
end

file "#{Chef::Config[:file_cache_path]}/nginx_sites_lock" do
  owner "root"
  group "root"
  mode "0755"
  action :touch
end
