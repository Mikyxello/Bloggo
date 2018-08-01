class Blog < ApplicationRecord

	is_impressionable
	acts_as_followable
	is_impressionable counter_cache: true
	has_many :posts, dependent: :destroy

	belongs_to :user

	validates :name, presence: true, length: { minimum: 5 }
end
