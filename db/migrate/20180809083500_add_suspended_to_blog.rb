class AddSuspendedToBlog < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :suspended, :boolean
  end
end
