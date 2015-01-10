apt_package "acl" do
  action :upgrade
end

group "adm" do
  action :create
end

bash "/usr/local permissions" do
  code <<-EOF
    chgrp -R adm /usr/local
    chmod -R g+rwxs /usr/local
    setfacl -m g:adm:rwx /usr/local
  EOF
  user "root"
end

directory "/var/lib/gems" do
  action :create
end

bash "/var/lib/gems permissions" do
  code <<-EOF
    chgrp -R adm /var/lib/gems
    chmod -R g+rwxs /var/lib/gems
    setfacl -m g:adm:rwx /var/lib/gems
  EOF
  user "root"
end

group "srv" do
  action :create
end

bash "/srv permissions" do
  code <<-EOF
    chgrp -R srv /srv
    chmod -R g+rwxs /srv
    setfacl -m g:adm:rwx /srv
  EOF
  user "root"
end
