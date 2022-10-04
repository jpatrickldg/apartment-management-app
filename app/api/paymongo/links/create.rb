class Paymongo::Links::Create
  def self.call(amount, description)
    require 'uri'
    require 'net/http'
    require 'openssl'

    url = URI("https://api.paymongo.com/v1/links")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["accept"] = 'application/json'
    request["content-type"] = 'application/json'
    request["authorization"] = 'Basic c2tfdGVzdF80TldlUFdIa1h5SjlnbUt3eXgzSHZ5Q3E6'
    request.body = "{\"data\":{\"attributes\":{\"amount\":#{amount},\"description\":\"#{description}\"}}}"

    response = http.request(request)
    puts response.read_body
    JSON.parse(response.read_body)
  end
end