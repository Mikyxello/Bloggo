class AdminPanelController < ApplicationController
  before_action :authenticate_user!, :check_user

  def index
    @blogs = Blog.all
    @posts = Post.all
    @users = User.all.order(:id)
    @tags = ActsAsTaggableOn::Tag.all
  end

  private

  def check_user
    if current_user.admin?
		    
    else
      redirect_to root_path
    end
  end
end
