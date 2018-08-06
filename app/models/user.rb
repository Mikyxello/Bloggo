class User < ApplicationRecord
	acts_as_voter
  acts_as_follower

	mount_uploader :avatar_image, ImageUploader

	has_many :blogs
	has_many :posts
	has_many :comments

	validates_presence_of :name, :surname

	#validates_presence_of   :avatar_image
  validates_integrity_of  :avatar_image
  validates_processing_of :avatar_image

	# Include default devise modules. Others available are:
	# :confirmable, :lockable, :timeoutable and :omniauthable
	devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
				 :omniauthable, :omniauth_providers => [:google_oauth2,:facebook]

	 #def self.from_omniauth(access_token)
	  # data = access_token.info
	   #user = User.where(:email => data["email"]).first

	   #unless user
	     #password = Devise.friendly_token[0,20]
	     #user = User.create(:name => data["first_name"],:surname => data["last_name"], email: data["email"],
	      # password: password, password_confirmation: password, avatar_image: data["image"]
	     #)
			# user.save!
	   #end
	  # user
	 #end

	 enum role: [:user, :bloggoer, :editor, :admin]
   after_initialize :set_default_role, :if => :new_record?

	 def set_default_role
    	self.role ||= :user
  	end

		def set_default_username
			self.username ||= self.name + self.surname
		end

	 def self.from_omniauth(auth)
	  where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
	    user.email = auth.info.email
	    user.password = Devise.friendly_token[0,20]
	    user.name = auth.info.first_name   # assuming the user model has a name
			user.surname = auth.info.last_name
			user.avatar_image = auth.info.image
			user.save!
	    # If you are using confirmable and the provider(s) you use validate emails,
	    # uncomment the line below to skip the confirmation emails.
	    # user.skip_confirmation!
	  end
	end

	 def self.new_with_session(params, session)
    super.tap do |user|
      if data = session["devise.facebook_data"] && session["devise.facebook_data"]["extra"]["raw_info"]
        user.email = data["email"] if user.email.blank?
      end
    end
  end


end
