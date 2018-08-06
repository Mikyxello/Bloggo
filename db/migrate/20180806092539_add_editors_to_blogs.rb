class AddEditorsToBlogs < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :editors, :integer, array: true, default: []
  end
end
