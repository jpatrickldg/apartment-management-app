FactoryBot.define do
  factory :inquiry do
    email { "inquiry@example.com" }
    first_name { "Inquiry" }
    last_name { "Test" }
    gender { "female" }
    contact_no { "09123232231" }
    address { "Quezon City" }
    occupation { "student" }
    location_preference { "test location" }
    room_type { "test room" }
    move_in_date { Date.today }
    birthdate { Date.today }
  end
end
