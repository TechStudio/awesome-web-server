MySQL: Create Database And User
===============================

When we need a MySQL database for a site it's best to
create a database and a user with privileges on that
database alone.

First we need to log in to MySQL as root to set everything up.
Be prepared to enter the root password.

```bash
mysql -u root -p
```

Next we'll create the database.

```mysql
CREATE DATABASE my_new_database;
```

Then we'll create a user and grant access to that database.

```mysql
CREATE USER 'my_new_user'@'localhost' IDENTIFIED BY 'password';
GRANT ALL PRIVILEGES ON my_new_database.* TO 'my_new_user'@'localhost';
```

Then let's flush the privileges before we leave.

```mysql
FLUSH PRIVILEGES;
QUIT;
```

To see a list of users, run this query.

```mysql
SELECT User FROM mysql.user;
```
