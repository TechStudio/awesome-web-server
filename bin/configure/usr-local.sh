# usr local should be owned by the admin group
sudo chgrp -R admin /usr/local

# usr local should have 7 permissions for the admin group
sudo chgrp -R g=u /usr/local
