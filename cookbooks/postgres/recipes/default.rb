packages = [
  'postgresql',
  'postgresql-contrib',
  'libpq-dev'
]

packages.each do |p|
  apt_package "#{p}" do
    action :upgrade
  end
end

service "postgresql" do
  supports :restart => true, :start => true, :stop => true, :reload => true
  action [:enable,:start]
end

template "/etc/profile.d/lang.sh" do
  source "lang.sh.erb"
  mode 0440
  owner "root"
  group "root"
  not_if "test -e /etc/profile.d/lang.sh"
end

bash "postgresql_set_en_us_utf8_template1" do
  code <<-EOF
    psql postgres -c "update pg_database set datistemplate=false where datname='template1'"
    psql postgres -c "drop database template1"
    psql postgres -c "create database template1 with owner=postgres encoding='UTF-8' lc_collate='en_US.utf8' lc_ctype='en_US.utf8' template template0"
    psql postgres -c "update pg_database set datistemplate=true where datname='template1'"
  EOF
  user "postgres"
  not_if "test -e #{Chef::Config[:file_cache_path]}/postgres_initial_config_lock"
end

file "#{Chef::Config[:file_cache_path]}/postgres_initial_config_lock" do
  owner "root"
  group "root"
  mode "0755"
  action :touch
end
