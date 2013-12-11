# usr local should be owned by the admin group
chgrp -R admin /usr/local

# usr local should have 7 permissions for the admin group
chmod -R g=u /usr/local
