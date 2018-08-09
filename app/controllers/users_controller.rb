class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
	  @user = current_user
		@blog = Blog.where(user_id: @user).last(5).reverse!
    @favourite_blogs = current_user.favorited_by_type 'Blog'
    @favourite_posts = current_user.favorited_by_type 'Post'
		end

 	def show
		@user = User.find(params[:id])
		@blog = Blog.where(user_id: @user)
    @favourite_blogs = @user.favorited_by_type 'Blog'
 	end

 	def upgrade
 		@user = current_user
		@blog = Blog.where(user_id: @user)
 		@user.bloggoer!
 		render 'index'
 	end

  def change_status
    @user = User.find(params[:id])
    if @user.banned == true
      @user.banned = false
    else
      @user.banned = true
    end
    @user.save
    redirect_to admin_panel_index_path
  end

  def destroy
    @user = User.find(params[:id])
    @user.destroy
    if current_user.admin?
		    redirect_to admin_panel_index_path
    else
      redirect_to root_path
    end
  end

  def create
    @user = User.create(user_params)
  end

 	private
 		def user_params
		    params.require(:user).permit(:email,:name,:surname, :header, :profile)
	  end
end
