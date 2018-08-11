FactoryBot.define do
	require 'faker'
	factory :post do
        title Faker::String.random(5..100)
        subtitle Faker::String.random
        content Faker::Lorem.words(100)
    end
end
