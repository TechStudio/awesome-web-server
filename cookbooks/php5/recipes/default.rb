packages = [
  'php5-fpm',
  'php5-mysql',
  'php5-gd'
]

packages.each do |p|
  apt_package "#{p}" do
    action :upgrade
  end
end

template "/etc/php5/fpm/php.ini" do
  source "php.ini.erb"
  mode 0644
  owner "root"
  group "adm"
  not_if "test -f #{Chef::Config[:file_cache_path]}/php5_lock"
end

template "/etc/php5/fpm/pool.d/" do
  source "www.conf.erb"
  mode 0644
  owner "root"
  group "adm"
  not_if "test -f #{Chef::Config[:file_cache_path]}/php5_lock"
end

file "#{Chef::Config[:file_cache_path]}/php5_lock" do
  owner "root"
  group "root"
  mode "0755"
  action :touch
end
