class HomeController < ApplicationController

  def index
    @blogs = if params[:blog]
			         Blog.where('name LIKE ?',"%#{params[:blog]}%")
		         else
			            Blog.all
		              end
    @posts = Post.all
    @tags = ActsAsTaggableOn::Tag.all.order("taggings_count").reverse.first(10)
  end


end
