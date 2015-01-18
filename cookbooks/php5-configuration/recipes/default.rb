lock = "#{Chef::Config[:file_cache_path]}/php5_configuration_lock"

template "/etc/php5/fpm/php.ini" do
  source "php.ini.erb"
  mode 0644
  owner "root"
  group "adm"
  not_if "test -f #{lock}"
end

template "/etc/php5/fpm/pool.d/www.conf" do
  source "www.conf.erb"
  mode 0644
  owner "root"
  group "adm"
  not_if "test -f #{lock}"
end

file lock do
  owner "root"
  group "root"
  mode "0755"
  action :touch
end
