FactoryBot.define do
	require 'faker'
	factory :post do
        title { Faker::String.random(5..50) }
        subtitle { Faker::String.random(0..50) }
        content { Faker::String.random(5..100) }
    end
end
