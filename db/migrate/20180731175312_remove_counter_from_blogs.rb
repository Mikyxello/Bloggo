class RemoveCounterFromBlogs < ActiveRecord::Migration[5.2]
  def change
    remove_column :blogs, :counter, :integer
  end
end
