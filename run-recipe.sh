# http://stackoverflow.com/a/18566301/2535178
sudo chef-solo -c solo.rb --override-runlist "recipe[$1]"