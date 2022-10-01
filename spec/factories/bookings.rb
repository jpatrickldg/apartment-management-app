FactoryBot.define do
  factory :booking do
    association :user
    association :room
    move_in_date { Date.today }

  end
end
