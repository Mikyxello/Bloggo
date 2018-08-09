class Blog < ApplicationRecord

	is_impressionable
	acts_as_followable
	is_impressionable :counter_cache => true, :column_name => :impressions_count
	has_many :posts, dependent: :destroy

	belongs_to :user

	validates :name, presence: true, length: { minimum: 5 }

	before_create do
		self.suspended = false
	end
end
