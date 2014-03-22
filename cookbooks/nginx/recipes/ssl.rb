# this doesn't work at the moment

nginx = data_bag_item("nginx","nginx")
primary_domain = nginx["primary_domain"]
ssl_dir = nginx["ssl_dir"]

directory "#{ssl_dir}" do
  owner "root"
  group "root"
  mode 0755
  action :create
  not_if "test -e #{ssl_dir}"
end

bash "create_self_signed_ssl_cert" do
  cwd "#{ssl_dir}"
  code "sudo openssl req -new -newkey rsa:4096 -days 3650 -nodes -x509 -subj \"/C=US/ST=/L=/O=/CN=#{primary_domain}\" -keyout server.key  -out server.cert"
  user "root"
  not_if "test -e #{ssl_dir}/server.key"
  not_if "test -e #{ssl_dir}/server.cert"
end
