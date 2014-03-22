template "/usr/local/bin/srv_own_prm" do
  source "srv_own_prm.erb"
  mode 0770
  owner "root"
  group "adm"
end
