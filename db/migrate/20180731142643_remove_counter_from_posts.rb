class RemoveCounterFromPosts < ActiveRecord::Migration[5.2]
  def change
    remove_column :posts, :counter, :integer
  end
end
