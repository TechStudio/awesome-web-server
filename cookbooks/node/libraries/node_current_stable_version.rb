require 'net/http'

def node_current_version
  url = URI.parse('http://nodejs.org/')
  req = Net::HTTP::Get.new(url.path)
  res = Net::HTTP.start(url.host, url.port) { |http|
    http.request(req)
  }

  res.body.match('(Current Version: v)(\d+\.\d+\.\d+)')[2]
end