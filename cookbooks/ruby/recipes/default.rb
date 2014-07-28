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

before_ruby.each do |p|
  apt_package "#{p}" do
    action :upgrade
  end
end

remote_file "/usr/local/src/ruby.tar.gz" do
  source "http://ftp.ruby-lang.org/pub/ruby/stable-snapshot.tar.gz"
  owner "root"
  group "adm"
  mode 0644
end

bash 'extract_ruby' do
  cwd "/usr/local/src"
  code <<-EOH
    tar zxf ruby.tar.gz
    rm ruby.tar.gz
  EOH
  user "root"
  group "adm"
  not_if "test -e #{Chef::Config[:file_cache_path]}/ruby_lock"
end

bash 'configure_ruby' do
  code "pushd /usr/local/src/stable-snapshot; ./configure"
  user "root"
  group "adm"
  not_if "test -e #{Chef::Config[:file_cache_path]}/ruby_lock"
end

bash 'make_ruby' do
  code "pushd /usr/local/src/stable-snapshot; make"
  user "root"
  group "adm"
  not_if "test -e #{Chef::Config[:file_cache_path]}/ruby_lock"
end

bash 'install_ruby' do
  code "pushd /usr/local/src/stable-snapshot; make install"
  user "root"
  group "adm"
  not_if "test -e #{Chef::Config[:file_cache_path]}/ruby_lock"
end

bash "maintain_usr_local_ownership_and_permissions_after_ruby" do
  code "/usr/local/bin/usr-local-permissions.sh"
  user "root"
  only_if "test -e /usr/local/bin/usr-local-permissions.sh"
end

gems.each do |g|
  bash "install_gem_#{g}" do
    code "gem install #{g} --no-ri --no-rdoc"
    user "root"
  end
end

file "#{Chef::Config[:file_cache_path]}/ruby_lock" do
  owner "root"
  group "root"
  mode "0755"
  action :touch
end
