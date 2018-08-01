class AddCounterCacheToBlog < ActiveRecord::Migration[5.2]
  def change

    add_column :blogs, :impressions_count, :integer
  end
end
