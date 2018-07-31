class HomeController < ApplicationController

  def index
    @blogs = if params[:blog]
			         Blog.where('name LIKE ?',"%#{params[:blog]}%")
		         else
			            Blog.all
		              end
    @posts = Post.all
  end


end
