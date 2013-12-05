require 'filesize'

class Numeric
  def percent_of(n)
    self.to_f / n.to_f * 100.0
  end
end

def free_memory
  results = {}

  free = `free -b`

  memory_warn = $config['resources']['memory_warn']
  memory_danger = $config['resources']['memory_danger']

  memory_total = free.split(' ')[7].to_i
  memory_free = free.split(' ')[9].to_i
  memory_total_pretty = Filesize.from(memory_total.to_s + ' B').pretty
  memory_free_pretty = Filesize.from(memory_free.to_s + ' B').pretty

  memory_percent_free = memory_free.percent_of(memory_total).round

  if memory_percent_free > memory_warn
    results[:result] = 2
  elsif memory_percent_free <= memory_warn && memory_percent_free > memory_danger
    results[:result] = 1
  else
    results[:result] = 0
  end

  results[:message] = "System memory: #{memory_free_pretty} of a total #{memory_total_pretty} (#{memory_percent_free}%) free."

  return results
end
