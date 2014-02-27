root = File.absolute_path(File.dirname(__FILE__))
file_cache_path root
cookbook_path root + '/cookbooks'
data_bag_path root + '/data_bags'
#environment_path root + '/environments'
file_cache_path = '/var/chef/cache'
Chef::Config[:file_cache_path]= '/var/chef/cache'
