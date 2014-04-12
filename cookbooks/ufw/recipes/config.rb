# pull these from data bags later
ports_allow_tcp = ['22','80','443']
ports_allow_udp = []

bash "config_ufw_defaults" do
  user "root"
  cwd "#{Chef::Config[:file_cache_path]}"
  code <<-EOH
    sudo ufw default deny incoming
    sudo ufw default allow outgoing
  EOH
  action :run
  not_if {File.exists?("#{Chef::Config[:file_cache_path]}/ufw_config_lock")}
end

ports_allow_tcp.each do |port|
  bash "config_ufw_port_allow_tcp_#{port}" do
    user "root"
    cwd "#{Chef::Config[:file_cache_path]}"
    code "sudo ufw allow #{port}/tcp"
    action :run
    not_if {File.exists?("#{Chef::Config[:file_cache_path]}/ufw_config_lock")}
  end
end

ports_allow_udp.each do |port|
  bash "config_ufw_port_allow_tcp_#{port}" do
    user "root"
    cwd "#{Chef::Config[:file_cache_path]}"
    code "sudo ufw allow #{port}/udp"
    action :run
    not_if {File.exists?("#{Chef::Config[:file_cache_path]}/ufw_config_lock")}
  end
end

bash "config_ufw_defaults" do
  user "root"
  cwd "#{Chef::Config[:file_cache_path]}"
  code "sudo ufw --force enable"
  action :run
  not_if {File.exists?("#{Chef::Config[:file_cache_path]}/ufw_config_lock")}
end

file "#{Chef::Config[:file_cache_path]}/ufw_config_lock" do
  owner "root"
  group "adm"
  mode "0755"
  action :create
end
