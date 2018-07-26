class Post < ApplicationRecord
	acts_as_taggable_on :tags

	has_many :comments, dependent: :destroy

	validates :title, presence: true, length: { minimum: 5 }

	belongs_to :blog
end
