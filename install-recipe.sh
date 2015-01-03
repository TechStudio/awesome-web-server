#!/usr/bin/env bash
sudo chef-solo -c solo.rb --override-runlist "recipe[$1]"
