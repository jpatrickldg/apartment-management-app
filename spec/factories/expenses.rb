FactoryBot.define do
  factory :expense do
    title { "Test Expense" }
    description { "Testing expense with rspec" }
    amount { 500 }
    processed_by { "test@example.com" }
    proof { Rack::Test::UploadedFile.new('spec/support/test_image.png', 'image/png') }
  end
end
