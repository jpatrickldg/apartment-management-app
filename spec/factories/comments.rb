FactoryBot.define do
  factory :comment do
    content { "MyText" }
    concern { nil }
  end
end
