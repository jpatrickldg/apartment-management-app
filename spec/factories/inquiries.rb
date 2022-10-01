FactoryBot.define do
  factory :inquiry do
    email { "inquiry@example.com" }
    first_name { "Inquiry" }
    last_name { "Test" }
    gender { "female" }
    contact_no { "09123232231" }
    location_preference { "test location" }
    room_type { "test room" }
    move_in_date { Date.today }
  end
end
