# https://github.com/sunspot/sunspot/wiki/Configure-Solr-on-Ubuntu,-the-quickest-way

packages = ["openjdk-6-jdk","solr-tomcat"]

packages.each do |p|
  package "#{p}" do
    action :upgrade
  end
end

service "tomcat6" do
  supports :restart => true, :start => true, :stop => true, :reload => true
  action [:enable,:start]
end
