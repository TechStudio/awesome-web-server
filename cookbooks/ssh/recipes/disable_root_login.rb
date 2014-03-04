ruby_block "disable_root_login" do
  block do
    file = Chef::Util::FileEdit.new("/etc/ssh/sshd_config")
    file.insert_line_if_no_match("PermitRootLogin no","PermitRootLogin no")
    file.write_file
  end
end
