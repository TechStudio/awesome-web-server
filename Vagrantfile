Vagrant.configure(2) do |config|

  config.vm.box = 'ubuntu/trusty64'

  hostname = "chef-solo-test"
  config.vm.hostname = hostname

  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', '512']
  end

  config.vm.synced_folder './', '/home/vagrant/chef-solo',
    owner: 'vagrant', group: 'vagrant',
    mount_options: ['dmode=755','fmode=755']

  config.vm.provision "chef_solo" do |chef|
    chef.node_name = hostname

    chef.add_recipe "essentials"
    chef.add_recipe "fish"
    chef.add_recipe "usr-local"
  end

end

