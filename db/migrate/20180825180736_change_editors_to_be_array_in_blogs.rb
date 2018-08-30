class ChangeEditorsToBeArrayInBlogs < ActiveRecord::Migration[5.2]
  def change
  	change_column :blogs, :editors,
  	:string, array: true
  end
end
