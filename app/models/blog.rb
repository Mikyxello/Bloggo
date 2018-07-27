class Blog < ApplicationRecord
	has_many :posts, dependent: :destroy

	belongs_to :user

	validates :name, presence: true, length: { minimum: 5 }
end
