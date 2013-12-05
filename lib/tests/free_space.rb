require 'sys/filesystem'
require 'filesize'

def free_space(loc="/")
  stat = Sys::Filesystem.stat(loc)
  available = stat.block_size * stat.blocks_available
  free = {
    :pretty => Filesize.from(available.to_s + ' B').pretty,
    :bytes => available
  }
  return free
end
