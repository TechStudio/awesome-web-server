#!/usr/bin/env bash
for cookbook in essentials fish nginx postgresql ruby node imagemagick sqlite3
do
  ./get-cookbook.sh $cookbook
done
