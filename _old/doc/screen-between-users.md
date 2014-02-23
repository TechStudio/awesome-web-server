Screen between users
====================

`screen` has to be installed as suid root for this to work

```bash
sudo chmod +s /usr/bin/screen
```

The user creating the screen will need to have a `.screenrc` file with this line in it.

```
term screen-256color
```

Inside screen do the following:

```
^A :multiuser on
^A :acladd fred
```

The other user can type:

```
screen -x username/
```
