# add each admin to wwwdata group
admins = data_bag("adm")

admins.each do |a|
  admin = data_bag_item("adm",a)
  user_id = admin["username"]

  group "wwwdata" do
    action :modify
    members "#{user_id}"
    append true
    only_if "id u #{user_id}"
  end
end

template "/usr/local/bin/srv_own_prm" do
  source "srv_own_prm.erb"
  mode 0770
  owner "root"
  group "adm"
end
