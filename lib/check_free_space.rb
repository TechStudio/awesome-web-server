require 'sys/filesystem'
require 'filesize'

def check_free_space(loc="/", style=false)
  stat = Sys::Filesystem.stat(loc)
  available = stat.block_size * stat.blocks_available
  if ( style == 'pretty' )
    return Filesize.from(available.to_s + ' B').pretty
  end
  return available
end

#puts check_free_space('/','pretty')
