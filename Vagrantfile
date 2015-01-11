hostname = "chef-solo-test"
project  = "chef-solo"
box      = "ubuntu/trusty64"
memory   = "512"
recipes  = %w{essentials fish permissions}

Vagrant.configure(2) do |config|
  config.vm.box = box
  config.vm.hostname = hostname

  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", memory]
    vb.customize ["modifyvm", :id, "--natdnshostresolver1", "on"]
  end

  config.vm.synced_folder "./", "/home/vagrant/#{project}",
    owner: "vagrant", group: "vagrant",
    mount_options: ["dmode=755","fmode=755"]

  config.vm.provision "chef_solo" do |chef|
    chef.node_name = hostname
    chef.cookbooks_path = "cookbooks"
    recipes.each { |r| chef.add_recipe r }
  end

  config.vm.provision "shell", inline: "sudo usermod -a -G adm vagrant"
  config.vm.provision "shell", inline: "touch ~/.gemrc && echo 'gem: --no-document' > ~/.gemrc"
end
