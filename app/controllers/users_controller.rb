class UsersController < ApplicationController
  before_action :authenticate_user!, except: [ :show ]

  def index
	  @user = current_user
		@blog = Blog.where(user_id: @user).last(5).reverse!
    @favourite_blogs = current_user.favorited_by_type 'Blog'
    @favourite_posts = current_user.favorited_by_type 'Post'
	end

 	def show
		@user = User.friendly.find(params[:id])
		@blogs = Blog.where(user_id: @user)
    @posts = Post.where(:user_id => @user.id)
    @favourite_blogs = @user.favorited_by_type 'Blog'
 	end

 	def upgrade
 		@user = current_user
 		@user.bloggoer!
    redirect_to users_url
 	end

  def change_status
    if current_user.admin?
      @user = User.find(params[:id])
      if @user.banned?
        @user.banned = false
      else
        @user.banned = true
      end
      @user.save
      redirect_to admin_panel_index_path
    else
      redirect_to root_path
    end
  end

  def destroy
    if current_user.admin?
      @user = User.find(params[:id])
      @user.destroy
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
