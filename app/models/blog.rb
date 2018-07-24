class Blog < ApplicationRecord
	has_many :posts, dependent: :destroy
	validates :name, presence: true, length: { minimum: 5 }
end
