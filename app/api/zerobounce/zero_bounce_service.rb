require 'httparty'

class Zerobounce::ZeroBounceService
  include HTTParty

  base_uri 'https://api.zerobounce.net/v2'

  def self.validate_email(email)
    response = get('/validate', query: { api_key: ENV['ZERO_BOUNCE'], email: email })
    response.parsed_response
  end
end