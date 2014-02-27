#!/usr/bin/env ruby
require 'json'

config = JSON.parse(ARGV.first)

def check_postfix(config)
  results = {}

  which = `which postfix`
  if which.include?('not found')
    results['result'] = 'fail'
    results['message'] = 'Postfix not installed.'
    return results.to_json
  end

  conf = `cat /etc/postfix/main.cf`
  if conf.include?('inet_interfaces = 127.0.0.1')
    results['result'] = 'pass'
    return results.to_json
  end

  results['result'] = 'fail'
  results['message'] = 'Interface not limited to localhost.'

  return results.to_json
end

puts check_postfix(config)
