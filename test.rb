#!/usr/bin/env ruby
require 'colorize'
require 'ap'
require './lib/send_email.rb'
require 'yaml'

$config = YAML.load_file('./config.yml')

tests = []

Dir["./lib/tests/*.rb"].each do |file|
  require file
  test_name = tests.push(file.sub('./lib/tests/','').sub('.rb',''))
end

tests.each do |test|
  print test.gsub('_',' ').capitalize + ': '

  test_result = send(test)

  if test_result[:result] == 2
    print 'Pass'.green
  elsif test_result[:result] == 1
    print 'Warn'.yellow
  elsif test_result[:result] == 0
    print 'Fail'.red
  else
    print 'Warn'.yellow
    print test_result[:result]
  end

  if test_result[:result] != 2 
    print "\n\n"
    print test_result[:message]
    print "\n\n"
  end

  print "\n"
end
