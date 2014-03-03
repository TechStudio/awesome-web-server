apt_package "logrotate" do
  action :upgrade
end

service "logrotate" do
  supports :restart => true, :start => true, :stop => true, :reload => true
  action [:enable,:start]
end
