execute "update apt" do
  sudo apt-get update
end

execute "install the essentials" do
  sudo apt-get install --yes vim screen rsync wget curl zsh git htop build-essential
  #sudo update-alternatives --config editor
end