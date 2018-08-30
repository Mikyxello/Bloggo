FactoryBot.define do
	require 'faker'
	factory :comment do
		content { Faker::Lorem.paragraph }
	end
end
