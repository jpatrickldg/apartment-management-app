FactoryBot.define do
  factory :invoice do
    association :booking
    water_bill { 500 }
    electricity_bill { 500 }
    room_rate { 5000 }
    date_from { Date.today - 1.month }
    date_to { Date.today }
    remarks { "Monthly" }
  end
end
