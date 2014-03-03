ruby_block "disable_password_authentication" do
  block do
    file = Chef::Util::FileEdit.new("/etc/ssh/sshd_config")
    file.insert_line_if_no_match("PasswordAuthentication no","PasswordAuthentication no")
    file.write_file
  end
end
