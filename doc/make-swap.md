```bash
sudo dd if=/dev/zero of=/swap.512mb bs=1M count=512
sudo mkswap /swap.512mb
sudo vim /etc/fstab
/swap.512mb swap  swap  defaults  0 0
sudo swapon -a
```
