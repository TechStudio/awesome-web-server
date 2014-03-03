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

bash "usr_local_owned_by_adm_group" do
  code "chgrp -R adm /usr/local; chmod -R 774 /usr/local"
  user "root"
end

cron "maintain_usr_local_owned_by_adm_group" do
  action :create
  user "root"
  command "chgrp -R adm /usr/local; chmod -R 774 /usr/local"
end
