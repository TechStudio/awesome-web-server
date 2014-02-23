#!/usr/bin/env ruby
require 'colorize'
require 'ap'
require './lib/send_email.rb'
require 'yaml'
require 'json'

class String
  def initial
    self[0,1]
  end
end

tests = []

if !File.exist?('./config.yml')
  abort("You need a config.yml to run tests. Try renaming the config.sample.yml to config.yml and making updates to personalize.")
end

begin
  config = YAML.load_file('./config.yml').to_json.gsub("'", %q(\\\'))
rescue => e
  abort("Error parsing config: #{e}")
end

Dir["./lib/tests/*.rb"].each do |file|
  tests.push(file)
end
tests.sort!

tests.each do |file|
  file_name = file.sub('./lib/tests/','') 
  test = file_name.sub('.rb','').gsub('_',' ').capitalize

  if file_name.initial == '_'
    next
  end

  print test + ': '
  
  begin
    test_result = JSON.parse(`#{file} '#{config}'`)
  rescue => e
    abort("Error parsing results: #{e}")
  end

  if test_result['result'] == 'pass'
    print test_result['result'].capitalize.green
  elsif test_result['result'] == 'fail'
    print test_result['result'].capitalize.red
  else
    print test_result['result'].capitalize.yellow
  end

  if test_result['result'] != 'pass'
    print "\n"
    print test_result['message']
  end

  print "\n"
end
