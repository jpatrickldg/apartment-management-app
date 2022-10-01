FactoryBot.define do
  factory :concern do
    association :user
    title { "Test Concern" }
    description { "Testing concern with rspec" }
  end
end
