class AddHeaderAndProfileToBlog < ActiveRecord::Migration[5.2]
  def change
    add_column :blogs, :header, :string
    add_column :blogs, :profile, :string
  end
end
