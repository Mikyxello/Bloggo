class Post < ApplicationRecord
	include Friendlyable
	
	acts_as_taggable_on :tags
	acts_as_votable
	acts_as_favoritable

	is_impressionable :counter_cache => true, :column_name => :impressions_count

	mount_uploader :file, FileUploader

	validates_integrity_of :file
	validates_processing_of :file

	has_many :comments, dependent: :destroy

	validates :title, presence: true, length: { minimum: 5, maximum: 100 }
	validates :subtitle, length: { maximum: 200 }
	validates :content, presence: true, length: { minimum: 1 }
	validates :user_id, presence: true

	validate :tag_list_count

	def tag_list_count
		errors[:tag_list] << "5 tags maximum" if tag_list.count > 5
		self.tag_list.each do |tag|
			errors[:tag_list] << "#{tag} must be shorter than 15 characters maximum" if tag.length > 15
			errors[:tag_list] << "#{tag} must be longer than 3 characters minimum" if tag.length < 3
		end
	end

	belongs_to :blog
	belongs_to :user
end
