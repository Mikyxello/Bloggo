class Comment < ApplicationRecord
	has_ancestry
	
	validates :content, presence: true, length: { minimum: 1, maximum: 1000 }

	belongs_to :post, :class_name => "Post", :foreign_key => "post_id"
	belongs_to :user, :class_name => "User", :foreign_key => "user_id"
end
