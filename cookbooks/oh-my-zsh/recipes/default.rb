# set to vagrant for now, need to use current user though
user_id = "vagrant"

git "/home/#{user_id}/.oh-my-zsh" do
  repository "https://github.com/robbyrussell/oh-my-zsh.git"
  reference "master"
  user user_id
  group user_id
  action :checkout
  not_if "test -d /home/#{user_id}/.oh-my-zsh"
end

execute "copy .zshrc template" do
  command "cp /home/#{user_id}/.oh-my-zsh/templates/zshrc.zsh-template /home/#{user_id}/.zshrc"
  user user_id
  action :run
  not_if "test -e /home/#{user_id}/.zshrc"
end

execute "set zsh as default shell" do
  command "chsh -s /bin/zsh #{user_id}"
end
