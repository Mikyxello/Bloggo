class User < ApplicationRecord
	acts_as_voter

	mount_uploader :avatar_image, ImageUploader

	has_many :blogs
	has_many :posts
	has_many :comments

	validates_presence_of :name, :surname

	validates_presence_of   :avatar_image
  validates_integrity_of  :avatar_image
  validates_processing_of :avatar_image

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
				 :omniauthable, :omniauth_providers => [:google_oauth2,:facebook]

	 def self.from_omniauth(access_token)
	   data = access_token.info
	   user = User.where(:email => data["email"]).first

	   unless user
	     password = Devise.friendly_token[0,20]
	     user = User.create(:name => data["first_name"],:surname => data["last_name"], email: data["email"],
	       password: password, password_confirmation: password, avatar_image: data["image"]
	     )
			 user.save!
	   end
	   user
	 end

	 def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end


end
