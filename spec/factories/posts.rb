FactoryBot.define do
	require 'faker'
	factory :post do
        title Faker::String.random(5..100)
        subtitle Faker::String.random(0..200)
        content Faker::String.random(1..1000)
    end
end
