Vagrant.configure(2) do |config|
  config.vm.box = 'ubuntu/trusty64'
  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', '512']
  end
  config.vm.synced_folder './', '/vagrant', owner: 'vagrant', group: 'vagrant', mount_options: ['dmode=755','fmode=755']
end
