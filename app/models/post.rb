class Post < ApplicationRecord
	acts_as_taggable_on :tags

	acts_as_votable

	mount_uploader :image, ImageUploader

	has_many :comments, dependent: :destroy

	validates :title, presence: true, length: { minimum: 5 }
	validates :content, presence: true, length: { minimum: 1 }

	belongs_to :blog
	belongs_to :user
end
