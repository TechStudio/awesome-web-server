execute "updateapt" do
  command "sudo apt-get update"
  action :run
  ignore_failure true
end

initial_packages = [
  'screen',
  'rsync',
  'wget',
  'curl',
  'zsh',
  'git',
  'htop',
  'build-essential'
]

initial_packages.each do |p|
  apt_package "#{p}" do
    action :upgrade
  end
end

template "/usr/local/bin/usr-local-permissions.sh" do
  source "usr-local-permissions.sh.erb"
  mode 0770
  owner "root"
  group "adm"
  not_if "test -e /usr/local/bin/usr-local-permissions.sh"
end

cron "maintain_usr_local_permissions" do
  command "/usr/local/bin/usr-local-permissions.sh"
end
