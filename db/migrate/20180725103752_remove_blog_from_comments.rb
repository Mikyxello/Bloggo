class RemoveBlogFromComments < ActiveRecord::Migration[5.2]
  def change
  	remove_reference :comments, :blog, index: true, foreign_key: true
  end
end
