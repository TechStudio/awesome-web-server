Apt: Use Digital Ocean Mirror
=============================

Back up the old sources.list file.

```bash
sudo mv /etc/apt/sources.list /etc/apt/sources.list.old
```

Copy the new sources.list into place.

```bash
sudo cp ~/awesome-web-server/etc/apt/sources.list /etc/apt/sources.list
```

Update apt.

```bash
sudo apt-get update
```
