FactoryBot.define do
  require 'faker'
  factory :user do |u|
    u.name = Faker::Name.first_name
    u.surname = Faker::Name.last_name
    u.username = Faker::Internet.username(5..8)
    u.banned = false
    u.email = Faker::Internet.email
    u.encrypted_password = Faker::Internet.password
    u.created_at = Faker::Time.between(DateTime.now - 5, DateTime.now)
    u.updated_at = Faker::Time.between(DateTime.now - 5, DateTime.now)
    u.avatar_image = Faker::Avatar.image
    u.role = :user
    u.uid = Faker::Number.number(3)
  end

  #factory :devise_user do |u|

  #end
end
