class FixColumnName < ActiveRecord::Migration[5.2]
  def change
  	rename_column :posts, :image, :file
  end
end
