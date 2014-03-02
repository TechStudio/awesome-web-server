package "php5-fpm" do
  action :upgrade
end

package "php5-mysql" do
  action :upgrade
end

ruby_block "dont_expose_php_version" do
  block do
    file = Chef::Util::FileEdit.new("/etc/php5/fpm/php.ini")
    file.insert_line_if_no_match("expose_php = Off","expose_php = Off")
    file.write_file
  end
end

ruby_block "set_sendmail_path" do
  block do
    file = Chef::Util::FileEdit.new("/etc/php5/fpm/php.ini")
    file.insert_line_if_no_match("sendmail_path = /usr/sbin/sendmail -t -i","sendmail_path = /usr/sbin/sendmail -t -i")
    file.write_file
  end
end
