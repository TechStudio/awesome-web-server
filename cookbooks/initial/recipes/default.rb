execute "updateapt" do
  command "sudo apt-get update"
  action :run
  ignore_failure true
  #not_if {File.exists?("#{Chef::Config[:file_cache_path]}/updateapt")}
end

#file "#{Chef::Config[:file_cache_path]}/updateapt" do
#  owner "root"
#  group "root"
#  mode "0600"
#  action :create
#end
