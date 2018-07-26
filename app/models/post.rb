class Post < ApplicationRecord
	acts_as_taggable_on :tags

	acts_as_votable

	has_many :comments, dependent: :destroy

	validates :title, presence: true, length: { minimum: 5 }

	belongs_to :blog
end
