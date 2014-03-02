bs = "1M"
count = "1024"

execute "create_swap_file" do
  command "dd if=/dev/zero of=/swap bs=#{bs} count=#{count}"
  user "root"
end

execute "make_swap" do
  command "mkswap /swap"
  user "root"
end

# Add the following line to fstab so the swap will exist after reboot.
# /swap.512mb swap  swap  defaults  0 0

execute "swap_on" do
  command "swapon -a"
  user "root"
end
