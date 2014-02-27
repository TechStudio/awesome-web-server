common_npms = ['grunt-cli','bower']

common_npms.each do |npm|
  execute "NPM: install #{npm}" do
    command "npm i -g #{npm}"
    user "root"
    action :run
  end
end
