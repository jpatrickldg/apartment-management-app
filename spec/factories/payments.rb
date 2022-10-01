FactoryBot.define do
  factory :payment do
    association :invoice
    amount { 5000 }
  end
end
