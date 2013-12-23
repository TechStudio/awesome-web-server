Configure Sudoers
=================

We want admins to have `sudo` privileges without the nuisance of a password.

In order to update the sudoers configuration we'll run the following command.
Run this as root.

```bash
visudo
```

Make sure the following line is in place. It's there by default in most cases.

```
%adm ALL=NOPASSWD: ALL
```

Next make sure all users who need sudo privilegs are members of the admin group.
Here's how to add a user to the group. This also must be run as root. Replace
"username" with the desired user.

```bash
usermod -G admin username
```
