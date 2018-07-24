class CreatePosts < ActiveRecord::Migration[5.2]
  def change
    create_table :posts do |t|
      t.string :title
      t.string :subtitle
      t.text :content
      t.references :blog, foreign_key: true

      t.timestamps
    end
  end
end
