awesome web server
==================

The goal of **awesome web server** is to document a functional and secure web server config
with the following capabilities:

+ SSH
+ SFTP
+ MySQL
+ WWW
  + Nginx
  + Apache (reverse proxy behing Nginx)
+ Rails
+ Node

This project is meant for use with Ubuntu 12.x. It might worth on other versions, but
there are no guarantees. If anyone wants to work on a branch for another version please
feel free.

Installing
----------

The `./bin/install/` directory contains scripts meant for easy install of packages needed
for a web server.

Start by running the initial script and performing initial configuration tasks.

```
./bin/install/initial.sh
```

Other initial tasks include setting the server hostname, creating a non-root user, and
giving sudoers priveliges.

@coolaj86 has a [good blog post][1] about [initial VPS configuration][1].

The Ruby/RVM, Rubygems, Bundle, and Nodejs scripts should be run next. The tests depend
upon these.

```
./bin/install/ruby-and-rvm.sh
./bin/install/rubygems.sh
bundle
./bin/install/nodejs.sj
```

At this point the server tests can be run. It's a good idea to get the SSH test to a passing
result before moving further.

Configuring
-----------

>> Coming soon.

Tests
-----

After basic configuration is in place, `tests.rb` can be run. This will run all
tests in the `./lib/tests/` directory.

Tests are a great way to work through a checklist making sure all the basics are
in place for a healthy web server.

The following tests are in place:

+ Free Memory
+ Free Space
+ Rails

The following tests need to be written:

+ SSH
  + Disable root login
  + Disable password authentication

### How To Write A Test

A test can be written in any language. The `test.rb` script will run each script in the
`/lib/tests` directory, passing the local configuration as a string of JSON. Take a look
at `config.sample.yml` to see what configuration variables are availale and will be passed
to a test when it is called.

All tests must return JSON formatted as follows.

```JSON
{ "result": "pass", # can be pass, fail, or warn
, "message": "Hello world" # the message will be displayed if the result is not a pass
}
```

If the new test requires options, don't forget to update `config.sample.yml`.
Update dependecies via Gemfile,
package.json, or wherever it is neccessary for your additions.

License and Warranty
--------------------

This repository is licensed under GPL3 and comes with no warranty. Use at your own risk.

[1]: http://blog.coolaj86.com/articles/how-i-setup-my-vpses.html
