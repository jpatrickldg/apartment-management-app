Semaphore::Sms.setup do |config|
  config.api_key = ENV['SEMAPHORE_KEY']
  # NOTE: add if you want to use a single sender name by default.
  # config.sender_name = "SEMAPHORE"
end
