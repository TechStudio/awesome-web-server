apt_package "ssh" do
  action :upgrade
end

service "ssh" do
  supports :restart => true, :start => true, :stop => true, :reload => true
  action [:enable,:start]
end
