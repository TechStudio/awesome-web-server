template "/usr/local/bin/usr_local_prm" do
  source "usr_local_prm.erb"
  mode 0774
  owner "root"
  group "adm"
  not_if "test -e /usr/local/bin/usr-local-permissions.sh"
end

execute "usr_local_prm" do
  command "/usr/local/bin/usr_local_prm"
  action :run
end

cron "usr_local_prm" do
  command "/usr/local/bin/usr_local_prm"
end
