FactoryBot.define do
	require 'faker'
	factory :comment do
		content Faker::Lorem.words(20)
	end
end
