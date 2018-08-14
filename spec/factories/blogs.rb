FactoryBot.define do
	require 'faker'
	factory :blog do
        name { Faker::String.random (5..100) }
        description { Faker::String.random }
    end
end