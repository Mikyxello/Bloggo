class Blog < ApplicationRecord

	is_impressionable
	acts_as_followable
  acts_as_favoritable
	is_impressionable :counter_cache => true, :column_name => :impressions_count
	has_many :posts, dependent: :destroy

	mount_uploader :header, ImageUploader
	validates_integrity_of :header
	validates_processing_of :header

	mount_uploader :profile, ImageUploader
	validates_integrity_of :profile
	validates_processing_of :profile

	belongs_to :user

	validates :name, presence: true, length: { minimum: 5 }

	before_create do
		self.suspended = false
	end

	def self.search(params)
		blog = Blog.where('name LIKE ?',"%#{params[:search]}%")
	end
end
