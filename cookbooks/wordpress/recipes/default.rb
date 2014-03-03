wordpress_sites = data_bag("wordpress_sites")

wordpress_sites.each do |w|
  site = data_bag_item("wordpress_sites",w)

  domain = site["domain"]
  database = data_bag_item("mysql_user_database_pairs",site["database"])

  directory "/var/www/#{domain}" do
    owner "www-data"
    group "adm"
    mode 0775
    action :create
    not_if "test -e /var/www/#{domain}"
  end

  remote_file "/var/www/#{domain}/wordpress.tar.gz" do
    source "http://wordpress.org/latest.tar.gz"
    mode 0664
    owner "www-data"
    group "adm"
    action :create_if_missing
  end

  bash 'extract_wordpress' do
    cwd "/var/www/#{domain}"
    code <<-EOH
      tar zxf wordpress.tar.gz
      rm wordpress.tar.gz
      EOH
    not_if "test -e /var/www/#{domain}/wordpress"
  end

  bash 'remove_unneeded_files' do
    code <<-EOH
      rm /var/www/#{domain}/wordpress/readme.html
      rm /var/www/#{domain}/wordpress/license.txt
      rm /var/www/#{domain}/wordpress/wp-config-sample.php
    EOH
  end

  # add index file to http root

  # add wp-config.php using template

  # import database if provided

  # rsync wp-content folder into place if provided
end
