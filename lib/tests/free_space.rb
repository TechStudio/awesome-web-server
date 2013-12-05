#!/usr/bin/env ruby
require 'sys/filesystem'
require 'filesize'
require 'json'

config = JSON.parse(ARGV.first)

def free_space(config)
  results = {}

  loc = config['resources']['space_loc']
  space_warn = config['resources']['space_warn']
  space_danger = config['resources']['space_danger']

  stat = Sys::Filesystem.stat(loc)
  available = stat.block_size * stat.blocks_available
  available_pretty = Filesize.from(available.to_s + ' B').pretty

  if available > space_warn
    results[:result] = 'pass'
  elsif available <= space_warn && available > space_danger
    results[:result] = 'warn'
  else
    results[:result] = 'fail'
  end

  results[:message] = "Disk space remaining: #{available_pretty}"

  return results.to_json
end

puts free_space(config)
