# Notes

The most frequently used chef document will the [resources documentation][1]
at the Opscode site.

It's important to read [The Anatomy Of A Chef Run][2].

## Install chef

```bash
curl -L http://www.opscode.com/chef/install.sh | sudo bash
```

## Run chef

sudo chef-solo -c solo.rb -j run_list.json -E [] -N []

-E environment  
-N node create a common naming pattern ie. do-sf1-nginx-20140224  

[1]: http://docs.opscode.com/chef/resources.html
[2]: #