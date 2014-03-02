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
  package "#{p}" do
    action :upgrade
  end
end
