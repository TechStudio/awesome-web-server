require 'sys/filesystem'
require 'filesize'

def free_space(loc="/")
  results = {}

  space_warn = $config['resources']['space_warn']
  space_danger = $config['resources']['space_danger']

  stat = Sys::Filesystem.stat(loc)
  available = stat.block_size * stat.blocks_available
  available_pretty = Filesize.from(available.to_s + ' B').pretty

  if available > space_warn
    results[:result] = 2
  elsif available <= space_warn && available > space_danger
    results[:result] = 1
  else
    results[:result] = 0
  end

  results[:message] = "Disk space remaining: #{available_pretty}"

  return results
end
