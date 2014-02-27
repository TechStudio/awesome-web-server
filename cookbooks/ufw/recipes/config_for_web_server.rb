bash "ufw_enable" do
  user "root"
  cwd "#{Chef::Config[:file_cache_path]}"
  code <<-EOH
    sudo ufw default deny incoming
    sudo ufw default allow outgoing
    sudo ufw allow 22/tcp
    sudo ufw allow 80/tcp
    sudo ufw allow 443/tcp
    sudo ufw enable
  EOH
  action :run
  not_if {File.exists?("#{Chef::Config[:file_cache_path]}/ufw_enable")}
end

file "#{Chef::Config[:file_cache_path]}/ufw_enable" do
  owner "root"
  group "root"
  mode "0755"
  action :create
end
