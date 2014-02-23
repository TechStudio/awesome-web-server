# Postgres initial on Ubuntu

> http://stackoverflow.com/a/17565205/2535178

### Create a file
touch /etc/profile.d/lang.sh

### Add the following

```
export LANGUAGE="en_US.UTF-8"
export LANG="en_US.UTF-8"
export LC_ALL="en_US.UTF-8"
```

### Reconfigure so the encoding can be UTF8

```
sudo su postgres -c psql
```

```sql
update pg_database set datistemplate=false where datname='template1';
drop database Template1;
create database template1 with owner=postgres encoding='UTF-8'
lc_collate='en_US.utf8' lc_ctype='en_US.utf8' template template0;
update pg_database set datistemplate=true where datname='template1';
```
