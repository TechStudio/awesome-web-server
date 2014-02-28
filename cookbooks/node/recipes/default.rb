current_version = node_current_version
current_installed_version = "" # get from lock file
nodejs_tar = "node-v#{current_version}-linux-x64.tar.gz"
nodejs_tar_dir = nodejs_tar.gsub(/.tar.gz/,'')
nodejs_bin_url = "http://nodejs.org/dist/v#{current_version}/#{nodejs_tar}"
destination_dir = "/usr/local"
install_dirs = ['lib','bin','share']

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
  not_if "test -f #{Chef::Config[:file_cache_path]}/node_lock"
end

install_dirs.each do |dir|
  execute "sparse_copy_node_#{dir}_into_local" do
    command "rsync -a /usr/local/src/#{nodejs_tar_dir}/#{dir}/ /usr/local/#{dir}/"
    user "root"
    action :run
    not_if "test -f #{Chef::Config[:file_cache_path]}/node_lock"
  end
end

file "#{Chef::Config[:file_cache_path]}/node_lock" do
  owner "root"
  group "root"
  mode "0755"
  action :touch
  # want to put version in file #{current_version}
end
