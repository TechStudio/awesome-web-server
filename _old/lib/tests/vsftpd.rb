#!/usr/bin/env ruby
require 'json'

config = JSON.parse(ARGV.first)

def check_vsftpd(config)
  results = {}
  
  test = `echo "bye" | nc localhost 21`

  if test.include? "vsFTPd"
    results['result'] = 'pass'
  else
    results['result'] = 'fail'
  end
  
  return results.to_json
end

puts check_vsftpd(config)
