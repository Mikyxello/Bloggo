FactoryBot.define do
	require 'faker'
	factory :blog do
        name Faker::String.random
        description Faker::String.random
    end
end