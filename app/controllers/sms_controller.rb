class SmsController < ApplicationController
  before_action :authenticate_user!

  def send_message(message_body)
    client = Twilio::REST::Client.new

    # Sending an SMS message
    client.messages.create(
      from: ENV['TWILIO_NUMBER'],
      to: '+639398183397',
      body: message_body
    )
  end
end
