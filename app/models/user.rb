class User < ApplicationRecord
	acts_as_voter

	has_many :blogs
	has_many :posts
	has_many :comments

	validates_presence_of :name, :surname
	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
				 :omniauthable, :omniauth_providers => [:google_oauth2]

	 def self.from_omniauth(access_token)
	   data = access_token.info
	   user = User.where(:email => data["email"]).first

	   unless user
	     password = Devise.friendly_token[0,20]
	     user = User.create(:name => data["name"],:surname => data["surname"], email: data["email"],
	       password: password, password_confirmation: password, avatar_image: data["avatar_image"]
	     )
	   end
	   user
	 end


end
