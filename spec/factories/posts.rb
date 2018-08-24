FactoryBot.define do
	require 'faker'
	factory :post do
        title { Faker::Lorem.paragraph_by_chars(40) }
        subtitle { Faker::Lorem.paragraph_by_chars(50) }
        content { Faker::Lorem.paragraph_by_chars(100) }
    end
end
