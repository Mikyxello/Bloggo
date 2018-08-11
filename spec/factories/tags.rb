FactoryBot.define do
  factory :tag do
    name Faker::String.random(3..15)
  end
end
