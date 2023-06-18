# require "semaphore-sms"

class SmsController < ApplicationController
  before_action :authenticate_user!

  def send_message
    client = Semaphore::Sms.client

    # Sending an SMS message
    client.send("Hello World", "09086102431")
  end
end
