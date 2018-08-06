class AdminPanelController < ApplicationController

  def index
    @blogs = Blog.all
    @posts = Post.all
    @users = User.all.order(:id)
    @tags = ActsAsTaggableOn::Tag.all
  end
end
