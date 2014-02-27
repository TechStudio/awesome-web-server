execute "updateapt" do
  command "sudo apt-get update"
  action :run
  ignore_failure true
  #not_if {File.exists?("#{Chef::Config[:file_cache_path]}/updateapt")}
end

file "#{Chef::Config[:file_cache_path]}/updateapt" do
  owner "root"
  group "root"
  mode "0600"
  action :touch
end

list = ['vim', 'screen', 'rsync', 'wget', 'curl', 'zsh', 'git', 'htop', 'build-essential']

list.each do |p|
  package "#{p}" do
    action :install
  end
end

# set default editor to vim
