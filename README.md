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

This project is meant for use with Ubuntu 12.04 x64.

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
+ Rails

...

### How To Write A Test

A test can be written in any language. The `test.rb` script will run each script in the
`/lib/tests` directory, passing the local configuration as a string of JSON.

All tests must return JSON formatted as follows.

```JSON
{ "result": "pass", # can be pass, fail, or warn
, "message": "Hello world" # the message will be displayed if the result is not a pass
}
```

If the new test requires options, don't forget to modify the `config.yml.example`. This
settings file is converted to JSON by the `test.rb` script. Update dependecies via Gemfile,
package.json, or wherever it is neccessary for new tests.
