apt_package "fail2ban" do
  action :upgrade
end

service "fail2ban" do
  supports :restart => true, :start => true, :stop => true, :reload => true
  action [:enable,:start]
end
