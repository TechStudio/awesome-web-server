bash "command" do
  sudo apt-get update
  sudo apt-get install --yes vim
  sudo apt-get install --yes screen
  sudo update-alternatives --config editor
  sudo apt-get install --yes rsync
  sudo apt-get install --yes wget
  sudo apt-get install --yes curl
  sudo apt-get install --yes zsh
  sudo apt-get install --yes git
  sudo apt-get install --yes htop
  sudo apt-get install --yes build-essential
end