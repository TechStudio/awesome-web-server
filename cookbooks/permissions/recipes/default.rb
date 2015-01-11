group "adm" do
  action :create
end

bash "/usr/local permissions" do
  code <<-EOF
    chgrp -R adm /usr/local
    chmod -R g+rwx /usr/local
    chmod g+s /usr/local
  EOF
  user "root"
end

directory "/var/lib/gems" do
  action :create
end

bash "/var/lib/gems permissions" do
  code <<-EOF
    chgrp -R adm /var/lib/gems
    chmod -R g+rwx /var/lib/gems
    chmod g+s /var/lib/gems
  EOF
  user "root"
end

group "srv" do
  action :create
end

bash "/srv permissions" do
  code <<-EOF
    chgrp -R srv /srv
    chmod -R g+rwx /srv
    chmod g+s /srv
  EOF
  user "root"
end
