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

Before starting the install process, make sure that you create a new user account for
yourself, add it to the admin group, give sudo/nopassword rights to that group, and
give ownership of `/usr/local` to admin.

```
# create a user account, replace me with your desired username
adduser me
# add yourself to admin group
usermod -G admin me
# make sure admin group has sudo/nopassword priveliges
visudo
```

Add the following line using `visudo` if not present already.

```
%admin ALL=NOPASSWD: ALL
```

Log back in using your new account. This is a good time to generate a key, add it to
the authorized keys and begin connecting without the use of a password. Digital Ocean
wrote a good post about [connecting to SSH with keys][4]. These instructions mirror
that post closely. These instructions assume, however, you are working from the terminal of the
server.

```
cd ~
mkdir .ssh
cd .ssh
touch authorized_keys
# don't worry about using a passphrase
ssh-keygen -t rsa
cat id_rsa.pub > authorized_keys
```

Next I usually just cat the key and keep it locally for making connections to the server.

```
cat id_rsa.key
```

At this point, go ahead and switch over to your own account.

```
./bin/configure/usr-local.sh
```

The `./bin/install/` directory contains scripts meant for easy install of packages needed
for a web server.

Start by running the initial script and performing initial configuration tasks.

```
./bin/install/initial.sh
```

Other initial tasks include setting the server hostname, creating a non-root user, and
giving sudoers priveliges.

@coolaj86 has a [good blog post][1] about [initial VPS configuration][1].

I like to install [oh-my-zsh][3] at this point.
Also refer to @coolaj86's [oh-my-zsh tutorial][2] for more info on what oh-my-zsh is.
Installing oh-my-zsh is easy, just run the install script which uses the `curl` method
listed on the oh-my-zsh README.

```
./bin/install/oh-my-zsh.sh
```

> Need to write about installing pathogen#infect and solarized for Vim here.

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

One of the important thigns to do to prepare SSH security is to install fail2ban. Install
with sudo.

```
sudo ./bin/install/fail2ban.sh
```

### Creating Install Scripts

Sometimes install scripts are as simple as one line, but just the fact that they are there
in the directory makes them worth having. They serve as a checklist if nothing else. Sometimes
a user will only cat the file to use it as documentation, but it's still nice to have.

Write Install Scripts as shell scripts. Include conditionals and feedback for the user if
you feel up to it.

Include sudo in commands that need it so users can always just run without the need of sudo
before the shell script itself.

Configuring
-----------

If you install Postfix, run the configuration for it with sudo.

```
sudo ./bin/configure/postfix.sh
```

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
[2]: http://blog.coolaj86.com/articles/zsh-is-to-bash-as-vim-is-to-vi.html
[3]: https://github.com/robbyrussell/oh-my-zsh
[4]: https://www.digitalocean.com/community/articles/how-to-set-up-ssh-keys--2
