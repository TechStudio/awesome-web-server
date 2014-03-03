admins = data_bag("adm")

git "/usr/local/src/oh-my-zsh" do
  repository "https://github.com/robbyrussell/oh-my-zsh.git"
  reference "master"
  user "root"
  action :checkout
end

admins.each do |a|
  admin = data_bag_item("adm",a)
  user_id = admin["username"]

  group "adm" do
    action :modify
    members "#{user_id}"
    append true
    only_if "id -u #{user_id}"
  end

  directory "/home/#{user_id}/.oh-my-zsh" do
    owner user_id
    group user_id
    mode 0700
    action :create
    only_if "id -u #{user_id}"
  end

  bash "install_oh_my_zsh_for_#{user_id}" do
    code "rsync -r /usr/local/src/oh-my-zsh/ /home/#{user_id}/.oh-my-zsh/"
    user "#{user_id}"
    group "adm"
    only_if "id -u #{user_id}"
  end

  bash "set_oh_my_zsh_permissions" do
    code "chmod -R 700 /home/#{user_id}/.oh-my-zsh"
    user "#{user_id}"
    group "adm"
    only_if "id -u #{user_id}"
  end

  bash "zshrc_template" do
    code "rsync -r /usr/local/src/oh-my-zsh/templates/zshrc.zsh-template /home/#{user_id}/.zshrc"
    user user_id
    group "adm"
    only_if "id -u #{user_id}"
    not_if "test -e /home/#{user_id}/.zshrc"
  end

  execute "set_zsh_as_default_shell_for_#{user_id}" do
    command "chsh -s /bin/zsh #{user_id}"
    only_if "id -u #{user_id}"
    user "root"
  end
end

execute "prevent_zcompinit_error" do
  command "chmod -R 755 /usr/local/share/zsh/site-functions"
  user "root"
end

cron "maintain_prevent_zcompinit_error" do
  action :create
  user "root"
  command "chmod -R 755 /usr/local/share/zsh/site-functions"
end
