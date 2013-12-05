require 'colorize'

loaded = []
tested = {}

Dir["./lib/*.rb"].each do |file|
  require file
  loaded.push(file)
end

loaded.each do |lib|
  print 'Loaded: '
  print lib.sub('./lib/','').sub('.rb','').green
  print "\n"
end

print "\n"

tested.each do |test,result|
  print test.capitalize + ': '
  if ( result === true )
    print 'Pass'.green
  elsif ( result === false )
    print 'Fail'.red
  else
    print result
  end
  print "\n"
end
