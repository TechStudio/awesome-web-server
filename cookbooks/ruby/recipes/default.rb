before_ruby = [
  'openssl',
  'libreadline6',
  'libreadline6-dev',
  'git-core',
  'zlib1g',
  'zlib1g-dev',
  'libssl-dev',
  'libyaml-dev',
  'libxml2-dev',
  'libxslt-dev',
  'autoconf',
  'libc6-dev',
  'ncurses-dev',
  'automake',
  'libtool',
  'bison',
  'subversion',
  'pkg-config'
]
gems = [
  'cyaml',
  'bundler'
]
ruby_version = "2.1.0"

bash "remove_previous_ruby_rvm" do
  code <<-EOF
    sudo apt-get remove --purge ruby-rvm ruby
    sudo rm -rf /usr/share/ruby-rvm /etc/rmvrc /etc/profile.d/rvm.sh
    rm -rf ~/.rvm* ~/.gem/ ~/.bundle*
  EOF
  not_if "test -f #{Chef::Config[:file_cache_path]}/rvm_lock" #todo || force?
end

ruby_block "add_rvm_to_bashrc_path" do
  block do
    file = Chef::Util::FileEdit.new("/home/vagrant/.bashrc")
    file.insert_line_if_no_match("export PATH=$HOME/.rvm/bin:$PATH","export PATH=$HOME/.rvm/bin:$PATH")
    file.write_file
  end
end

ruby_block "add_rvm_to_zshrc_path" do
  block do
    file = Chef::Util::FileEdit.new("/home/vagrant/.zshrc")
    file.insert_line_if_no_match("export PATH=$HOME/.rvm/bin:$PATH","export PATH=$HOME/.rvm/bin:$PATH")
    file.write_file
  end
end

bash "install_rvm" do
  code "curl -L https://get.rvm.io | bash -s stable"
  user "vagrant"
  not_if "test -f #{Chef::Config[:file_cache_path]}/rvm_lock" #todo || force?
end

before_ruby.each do |p|
  package "#{p}" do
    action :upgrade
  end
end

bash "install_ruby" do
  code "~/.rvm/bin/rvm install ruby #{ruby_version} --autolibs=0; ~/.rvm/bin/rvm use #{ruby_version}"
  user "vagrant"
  not_if "test -f #{Chef::Config[:file_cache_path]}/ruby_lock" #todo || force?
end

gems.each do |g|
  gem_package "#{g}" do
    :upgrade
  end
end

file "#{Chef::Config[:file_cache_path]}/rvm_lock" do
  owner "root"
  group "root"
  mode "0755"
  action :touch
end

file "#{Chef::Config[:file_cache_path]}/ruby_lock" do
  owner "root"
  group "root"
  mode "0755"
  action :touch
end
