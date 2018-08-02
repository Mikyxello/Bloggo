class ChangeImpressionsCountToPost < ActiveRecord::Migration[5.2]
  def change
  	change_column_default :posts, :impressions_count, 0
  end
end
