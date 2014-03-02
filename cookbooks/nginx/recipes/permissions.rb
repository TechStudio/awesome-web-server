bash "set_www_permissions" do
  command "chown -R www-data:adm /var/www; chmod -R 774 /var/www"
  user "root"
end

# Use template to create script
# Create cron job to run this every minute
# Consider totally different approach
