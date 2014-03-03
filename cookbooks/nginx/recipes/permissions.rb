directory "/var/www" do
  owner "www-data"
  group "adm"
  mode 0775
  action :create
  not_if "test -e /var/www"
end

cron "maintain_www_permissions" do
  action :create
  user "root"
  command "chown -R www-data:adm /var/www; chmod -R 774 /var/www"
end
