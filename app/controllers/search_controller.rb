class SearchController < ApplicationController

  def index
    @blogs = Blog.where('name LIKE ?',"%#{params[:q]}%")
    @posts = Post.where('title LIKE ?',"%#{params[:q]}%")
    @tags = ActsAsTaggableOn::Tag.where('name LIKE ?',"%#{params[:q]}%")


  end



end
