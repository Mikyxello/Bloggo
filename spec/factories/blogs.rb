FactoryBot.define do
	require 'faker'
	factory :blog do
        name { Faker::Lorem.paragraph_by_chars(50) }
        description { Faker::Lorem.paragraph }
    end
end