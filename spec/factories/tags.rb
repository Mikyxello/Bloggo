FactoryBot.define do
  factory :tag do
    name { Faker::Lorem.characters(10) }
  end
end
