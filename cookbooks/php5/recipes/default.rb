packages = [
  'php5-fpm',
  'php5-mysql'
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

file "#{Chef::Config[:file_cache_path]}/php5_lock" do
  owner "root"
  group "root"
  mode "0755"
  action :touch
end
