apt_package "postfix" do
  action :upgrade
end

service "postfix" do
  supports :restart => true, :start => true, :stop => true, :reload => true
  action [:enable,:start]
end
