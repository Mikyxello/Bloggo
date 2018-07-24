class Comment < ApplicationRecord
	validates :content, presence: true, length: { minimum: 1 }

	belongs_to :post	
end
