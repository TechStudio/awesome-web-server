require 'colorize'

loaded = []
tested = {}

Dir["./lib/*.rb"].each do |file|
  require file
  loaded.push(file)
end

# Free space test
danger_size = 1073741824
warn_size = 5368709120
free_space = check_free_space
if ( free_space[:bytes] < warn_size )
  tested['Free space'] = 2 
elsif ( free_space[:bytes] < danger_size )
  tested['Free space'] = false
else
  tested['Free space'] = true
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
  elsif ( result === 2 )
    print 'Warning'.yellow
  else
    print result
  end
  print "\n"
end
