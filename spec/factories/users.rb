FactoryBot.define do
  factory :user do
    sequence :email do |n|
      "test#{n}@example.com"
    end
    password { "SecretPassword123" }
    first_name { "tenant" }
    last_name { "tenant" }
    gender { "male" }
    birthdate { Date.today }
    contact_no { "09123232231" }
    address { 'Test Address' }
    confirmed_at { Time.now }
  end
end