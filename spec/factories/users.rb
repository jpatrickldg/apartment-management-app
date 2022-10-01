FactoryBot.define do
  factory :user do
    email { "pat@example.com" }
    password { "SecretPassword123" }
    first_name { "tenant" }
    last_name { "tenant" }
    gender { "male" }
    birthdate { Date.today }
    contact_no { "09123232231" }
    address { 'Quezon City' }
    role { "tenant" }
    confirmed_at { Time.now }
  end
end