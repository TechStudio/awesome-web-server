data_bag("my_data_bag")
db = data_bag_item("my_data_bag", "my")

datacenter = node.name.split('-')[0]
server_type = node.name.split('-')[1]
location = node.name.split('-')[2]

monitor_ip_address = db[node.chef_environment][location]['monitor']['ip_address']
monitor_hostname = db[node.chef_environment][location]['monitor']['hostname']
mmonit_username = db[node.chef_environment][location]['monitor']['admin']['username']
mmonit_password = db[node.chef_environment][location]['monitor']['admin']['password']
