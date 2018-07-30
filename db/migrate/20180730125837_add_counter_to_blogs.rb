class AddCounterToBlogs < ActiveRecord::Migration[5.2]
  def change
  	add_column :blogs, :counter, :integer, :default => 0
  end
end
