before_ruby = ['openssl','libreadline6','libreadline6-dev','git-core','zlib1g','zlib1g-dev','libssl-dev','libyaml-dev','libxml2-dev','libxslt-dev','autoconf','libc6-dev','ncurses-dev','automake','libtool','bison','subversion','pkg-config']
gems = ['cyaml','bundler']

bash "remove_previous_ruby_rvm" do
  code <<-EOF
    sudo apt-get remove --purge ruby-rvm ruby
    sudo rm -rf /usr/share/ruby-rvm /etc/rmvrc /etc/profile.d/rvm.sh
    rm -rf ~/.rvm* ~/.gem/ ~/.bundle*
  EOF
  not_if "test -f #{Chef::Config[:file_cache_path]}/ruby_lock" #todo || force?
end

#todo use template to do this instead
bash "update_bash_zsh_path" do
  code <<-EOF
    echo "[[ -s '${HOME}/.rvm/scripts/rvm' ]] && source '${HOME}/.rvm/scripts/rvm'" >> ~/.bashrc
    echo "[[ -s '${HOME}/.rvm/scripts/rvm' ]] && source '${HOME}/.rvm/scripts/rvm'" >> ~/.zshrc
  EOF
  user "vagrant"
end

bash "install_rvm" do
  code "curl -L https://get.rvm.io | bash -s stable"
  user "vagrant"
end

before_ruby.each do |p|
  package "#{p}" do
    action :upgrade
  end
end

bash "install_ruby" do
  code "curl -L https://get.rvm.io | bash -s stable --ruby"
  user "vagrant"
end

gems.each do |g|
  gem_package "#{g}" do
    :upgrade
  end
end

file "#{Chef::Config[:file_cache_path]}/ruby_lock" do
  owner "root"
  group "root"
  mode "0755"
  action :touch
end
