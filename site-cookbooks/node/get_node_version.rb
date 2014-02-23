require 'net/http'

url = URI.parse('http://nodejs.org/')
req = Net::HTTP::Get.new(url.path)
res = Net::HTTP.start(url.host, url.port) { |http|
  http.request(req)
}

body = res.body
version = body.match('(Current Version: v)(\d+\.\d+\.\d+)')[2]

puts version