#!/usr/bin/env ruby
require 'colorize'
require 'ap'
require './lib/send_email.rb'
require 'yaml'
require 'json'

tests = []

begin
  config = YAML.load_file('./config.yml').to_json.gsub("'", %q(\\\'))
rescue => e
  abort("Error parsing config: #{e}")
end

Dir["./lib/tests/*.rb"].each do |file|
  tests.push(file)
end

tests.each do |file|
  test = file.sub('./lib/tests/','').sub('.rb','').gsub('_',' ').capitalize
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
