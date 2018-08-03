class RemoveParentIdFromComments < ActiveRecord::Migration[5.2]
  def change
    remove_column :comments, :parent_id, :integer
  end
end
