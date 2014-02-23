# usr local should be owned by the admin group
chgrp -R adm /usr/local

# usr local should have 7 permissions for the admin group
chmod -R g=u /usr/local
