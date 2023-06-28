FactoryBot.define do
  factory :review do
    user { nil }
    maintenance_satisfaction { 1 }
    responsiveness_effectiveness { 1 }
    common_area_cleanliness { 1 }
    lease_renewal_likelihood { 1 }
    recommend_apartment { 1 }
    comment { "MyText" }
  end
end
