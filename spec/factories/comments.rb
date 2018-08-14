FactoryBot.define do
	require 'faker'
	factory :comment do
		content { Faker::String.random(1..1000) }
	end
end
