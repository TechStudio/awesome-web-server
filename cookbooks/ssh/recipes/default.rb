apt_package "ssh" do
  action :upgrade
end

service "ssh" do
  supports :restart => true, :start => true, :stop => true, :reload => true
  action [:enable,:start]
end

ruby_block "disable_root_login" do
  block do
    file = Chef::Util::FileEdit.new("/etc/ssh/sshd_config")
    file.insert_line_if_no_match("PermitRootLogin no","PermitRootLogin no")
    file.write_file
  end
end
