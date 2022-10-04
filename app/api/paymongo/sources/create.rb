class Paymongo::Sources::Create
  def self.call(amount)
    require 'uri'
    require 'net/http'
    require 'openssl'

    url = URI("https://api.paymongo.com/v1/sources")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["accept"] = 'application/json'
    request["authorization"] = 'Basic c2tfdGVzdF80TldlUFdIa1h5SjlnbUt3eXgzSHZ5Q3E6'
    request["content-type"] = 'application/json'
    request.body = "{\"data\":{\"attributes\":{\"amount\":#{amount},\"redirect\":{\"success\":\"http://localhost:3000/success\",\"failed\":\"http://localhost:3000/failed\"},\"type\":\"gcash\",\"currency\":\"PHP\"}}}"
    puts request.body
    response = http.request(request)
    JSON.parse(response.read_body)
  end
end