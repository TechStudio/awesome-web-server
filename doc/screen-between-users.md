Screen between users
====================

`screen` has to be installed as suid root for this to work

```bash
sudo chmod +s /usr/bin/screen
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

Colors break .. there is a way to fix that though.
