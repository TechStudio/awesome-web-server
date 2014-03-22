# add each admin to www-data group
admins = data_bag("adm")

admins.each do |a|
  admin = data_bag_item("adm",a)
  user_id = admin["username"]

  group "www-data" do
    action :modify
    members "#{user_id}"
    append true
    only_if "id -u #{user_id}"
  end
end
