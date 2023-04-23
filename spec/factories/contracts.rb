FactoryBot.define do
  factory :contract do
    tenant_name { "MyString" }
    tenant_address { "MyText" }
    room_code { "MyString" }
    valid_from { "2023-04-22" }
    valid_to { "2023-04-22" }
    monthly_rate { "9.99" }
    date_signed { "2023-04-22" }
    status { 1 }
    booking { nil }
  end
end
