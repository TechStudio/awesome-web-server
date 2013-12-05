require 'filesize'

class Numeric
  def percent_of(n)
    self.to_f / n.to_f * 100.0
  end
end

def check_free_memory
  free = `free -b`

  memory = {
    :bytes => {
      :total => free.split(' ')[7].to_i,
      :free => free.split(' ')[9].to_i
    },
    :pretty => {
      :total => Filesize.from(free.split(' ')[7].to_s + 'B').pretty,
      :free => Filesize.from(free.split(' ')[9].to_s + 'B').pretty
    }
  }

  memory[:percent_free] = memory[:bytes][:free].percent_of(memory[:bytes][:total]).round

  return memory
end

#puts check_free_memory
