class AddHashIdToPosts < ActiveRecord::Migration[5.2]
  def change
  	add_column :posts, :hash_id, :string, index: true
  end
end
