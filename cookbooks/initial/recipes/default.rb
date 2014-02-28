execute "updateapt" do
  command "sudo apt-get update"
  action :run
  ignore_failure true
end

list = ['screen', 'rsync', 'wget', 'curl', 'zsh', 'git', 'htop', 'build-essential']

list.each do |p|
  package "#{p}" do
    action :upgrade
  end
end
