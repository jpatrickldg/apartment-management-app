FactoryBot.define do
  factory :room do
    association :branch
    monthly_rate { 5000 }
    room_code { 'TEST' }
    occupants_count { 5 }
    capacity_count { 10 }
  end
end
