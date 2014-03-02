mysql_initial = data_bag_item("mysql", "initial")
root_password = mysql_initial["root_password"]

pairs = data_bag("mysql_user_database_pairs")

pairs.each do |i|
  d = data_bag_item("mysql_user_database_pairs", i)
  db_name = d["db_name"]
  db_user = d["db_user"]
  db_pass = d["db_pass"]

  bash "mysql_create_database_#{db_name}" do
    command "mysql -u root -p\"#{root_password}\" -Bse \"CREATE DATABASE #{db_name};\""
    user "root"
    not_if "test -f #{Chef::Config[:file_cache_path]}/mysql_pair_#{db_name}_lock"
  end

  bash "mysql_create_user_#{db_user}" do
    command "mysql -u root -p\"#{root_password}\" -Bse \"CREATE USER #{db_user}@localhost IDENTIFIED BY #{db_pass};\""
    user "root"
    not_if "test -f #{Chef::Config[:file_cache_path]}/mysql_pair_#{db_name}_lock"
  end

  bash "mysql_grant_all_priv_to_#{db_user}" do
    command "mysql -u root -p\"#{root_password}\" -Bse \"GRANT ALL PRIVILEGES ON #{db_name}.* TO #{db_user}@localhost;\""
    user "root"
    not_if "test -f #{Chef::Config[:file_cache_path]}/mysql_pair_#{db_name}_lock"
  end

  file "#{Chef::Config[:file_cache_path]}/mysql_pair_#{db_name}_lock" do
    owner "root"
    group "root"
    mode "0755"
    action :touch
  end
end

bash "mysql_flush_priv" do
  command "mysql -u root -p\"#{root_password}\" -Bse \"FLUSH PRIVILEGES;\""
  user "root"
end
