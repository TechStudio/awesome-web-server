Web Server Config 
=================

The goal of this project is to document a function and secure web server config
with the following capabilities:

+ SSH
+ SFTP
+ MySQL
+ Nginx
+ Apache (reverse proxy behing Nginx)
+ Rails
+ Node

Configuring
-----------

...

Security
--------

We'll put a few things into place for security.

+ SSH
  + Disable root login
  + Disable password authentication
+ fail2ban

Tests
-----

After basic configuration is in place, `tests.rb` can be run. This will run all
tests in the `./lib/tests/` directory.

Current tests include:

+ Free Memory
+ Free Space

...

### How To Write A Test

Writing a test by creating a `.rb` file. Name your file the same as the function
within which will be run by the `tests.rb` script.

Utilize the `$config` hash which is pulled from the `config.yml` file. Keep frequently
modified variables and settings there for easy editing and future proofing.

All tests should return the following hash.

```
return = {
  :result => 0, # 0 for fail 1 for warn 2 for pass
  :message => '' # return a message which will be displayed if the status is not pass
}
```

Don't forget to modify the example config.yml and update the Gemfile for dependencies.
