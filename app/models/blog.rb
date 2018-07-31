class Blog < ApplicationRecord

	is_impressionable
	has_many :posts, dependent: :destroy

	belongs_to :user

	validates :name, presence: true, length: { minimum: 5 }
end
