# source code management example

data_bag("my_data_bag")
db = data_bag_item("my_data_bag", "my")

git_username = db['git']['Username']
git_password = db['git']['Password']
git_name = db['git']['Name']
git_email = db['git']['Email']
git_account = db['git']['Account']

package "git-core" do
  action :install
end

if node.chef_environment == "development"
  branch_name = "development"
elsif node.chef_environment == "staging"
  branch_name = "staging"
else
  branch_name = "master"
end

directory "/home/ubuntu/workspace/" do
  owner "root"
  group "root"
  #mode "0775"
  recursive true
  action :create
end

git_repos = node['environment']['git_repos'] 
git_repos.each do |repo|

  execute "git_stash" do
    cwd "/home/ubuntu/workspace/#{repo}"
    command "git stash"
    action :run
    only_if {File.exists?("/home/ubuntu/workspace/#{repo}")}
  end
  
  git "/home/ubuntu/workspace/#{repo}" do
      repository "https://#{git_username}:#{git_password}@github.com/#{git_account}/#{repo}.git"
      revision branch_name
      action :sync
      user "root"
  end

end

