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
=======
If you're going to use FTP, run the vsFTPd install script with sudo.

```
sudo ./bin/install/vsftpd.sh
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

If you installed vsFTPd, the configuration script will make the neccessary changes to make
sure it's only listening on the localhost interface.

```
sudo ./bin/configure/vsftpd.sh
```

If you installed Postfix, run the configuration for it with sudo.

```
sudo ./bin/configure/postfix.sh
```

[1]: http://blog.coolaj86.com/articles/how-i-setup-my-vpses.html
[2]: http://blog.coolaj86.com/articles/zsh-is-to-bash-as-vim-is-to-vi.html
[3]: https://github.com/robbyrussell/oh-my-zsh
[4]: https://www.digitalocean.com/community/articles/how-to-set-up-ssh-keys--2