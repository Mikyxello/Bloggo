class AddCounterToPosts < ActiveRecord::Migration[5.2]
  def change
  	add_column :posts, :counter, :integer
  end
end
