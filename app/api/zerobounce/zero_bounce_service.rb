require 'httparty'

class Zerobounce::ZeroBounceService
  include HTTParty

  base_uri 'https://api.zerobounce.net/v2'

  def self.validate_email(email)
    response = get('/validate', query: { api_key: 'a705d8c78db04161a19454d1234235b2', email: email })
    response.parsed_response
  end
end