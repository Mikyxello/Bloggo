FactoryBot.define do
	require 'faker'
	factory :user do
        name { Faker::Name.first_name }
        surname { Faker::Name.last_name }
        username { Faker::Internet.username(5..8) }
        birth_date { Faker::Date.birthday(18, 99) }
        email { Faker::Internet.safe_email }
        password { "password" }
        password_confirmation { "password" }
		role { 'user' }
		banned { false }

        trait :is_bloggoer do
          role { 'bloggoer' }
        end
    end


end
