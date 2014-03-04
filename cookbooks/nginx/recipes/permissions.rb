directory "/var/www" do
  owner "www-data"
  group "adm"
  mode 0774
  action :create
  not_if "test -e /var/www"
end

template "/usr/local/bin/www-permissions.sh" do
  source "www-permissions.sh.erb"
  mode 0770
  owner "root"
  group "adm"
  variables({
    user: "www-data",
    group: "adm",
    directory: "/var/www"
  })
end

cron "maintain_www_permissions" do
  command "/usr/local/bin/www-permissions.sh"
end
