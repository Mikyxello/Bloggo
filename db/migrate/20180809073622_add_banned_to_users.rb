class AddBannedToUsers < ActiveRecord::Migration[5.2]
  def change
    add_column :users, :banned, :boolean
  end
end
