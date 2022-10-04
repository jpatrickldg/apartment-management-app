class Paymongo::Payments::Create
  def self.call(amount, source_id)
    require 'uri'
    require 'net/http'
    require 'openssl'

    url = URI("https://api.paymongo.com/v1/payments")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Post.new(url)
    request["accept"] = 'application/json'
    request["content-type"] = 'application/json'
    request["authorization"] = 'Basic c2tfdGVzdF80TldlUFdIa1h5SjlnbUt3eXgzSHZ5Q3E6'
    request.body = "{\"data\":{\"attributes\":{\"amount\":#{amount},\"source\":{\"id\":\"#{source_id}\",\"type\":\"link\"},\"currency\":\"PHP\"}}}"

    puts request.body
    response = http.request(request)
    JSON.parse(response.read_body)
  end
end