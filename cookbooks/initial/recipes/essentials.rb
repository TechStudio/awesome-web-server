list = ['vim', 'screen', 'rsync', 'wget', 'curl', 'zsh', 'git', 'htop', 'build-essential']

list.each do |p|
  package "#{p}" do
    action :install
  end
end
