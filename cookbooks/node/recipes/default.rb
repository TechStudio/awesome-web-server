current_version = node_current_version
nodejs_tar = "node-v#{current_version}-linux-x64.tar.gz"
nodejs_tar_dir = nodejs_tar.gsub(/.tar.gz/,'')
nodejs_bin_url = "http://nodejs.org/dist/v#{current_version}/#{nodejs_tar}"
destination_dir = "/usr/local"

# want to check against lock and skip entire process if current version matches installed

remote_file "/usr/local/src/#{nodejs_tar}" do
  source nodejs_bin_url
  mode 0644
  action :create_if_missing
end

execute "extract_node_binaries" do
  command "tar xf /usr/local/src/#{nodejs_tar}; mv /#{nodejs_tar_dir} /usr/local/src/"
  user "root"
  action :run
end

execute "sparse_copy_node_bin_into_usr_local" do
  command "rsync -a /usr/local/src/#{nodejs_tar_dir}/bin/ /usr/local/bin/;"
  user "root"
  action :run
end

execute "sparse_copy_node_lib_into_usr_local" do
  command "rsync -a /usr/local/src/#{nodejs_tar_dir}/lib/ /usr/local/lib/;"
  user "root"
  action :run
end

execute "sparse_copy_node_share_into_usr_local" do
  command "rsync -a /usr/local/src/#{nodejs_tar_dir}/share/ /usr/local/share/;"
  user "root"
  action :run
end

file "#{Chef::Config[:file_cache_path]}/node_lock" do
  owner "root"
  group "root"
  mode "0755"
  action :touch
  # want to put version in file #{current_version}
end
