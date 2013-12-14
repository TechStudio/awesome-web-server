#!/usr/bin/env ruby
require 'json'

config = JSON.parse(ARGV.first)

def check_rails(config)
  results = {}
  
  test = `rails -v`

  if test.include? "Rails"
    version = test.gsub('Rails','').gsub(' ','').gsub("\n",'')
    results['result'] = 'pass'
    
    if version != config['rails']['version'] 
      results['result'] = 'warn'
      results['message'] = "Wrong version of Rails: #{version}"
    end
  else
    results['result'] = 'fail'
  end
  
  return results.to_json
end

puts check_rails(config)