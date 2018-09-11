class UsersController < ApplicationController
  before_action :authenticate_user!, except: [ :show ]

  def index
	  @user = current_user
    @blog_count = Blog.where(user_id: @user)
		@blog = Blog.where(user_id: @user).last(5).reverse!
    @favourite_blogs = current_user.favorited_by_type 'Blog'
    @favourite_posts = current_user.favorited_by_type 'Post'
	end

  def all
    @user = current_user
    @blog = Blog.where(user_id: @user)  
  end

 	def show
		#@user = User.friendly.find(params[:id])
    @user = User.find(params[:id])
		@blog = Blog.where(user_id: @user)
    @filter = "Newest"
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

  def visited_view
    @user = User.find(params[:id])
    @filter = "Most Visited"
    @blogs= Blog.where(user_id: @user)
    @blog = @blogs.order(:impressions_count).reverse.last(@blogs.count)
    render 'show'
  end

  def recent_view
    @user = User.find(params[:id])
    @filter = "Most Recent"
    @blogs = Blog.where(user_id: @user)
    @blog = @blogs.last(@blogs.count)
    render 'show'
  end

  def create
    @user = User.create(user_params)
  end

 	private
 		def user_params
		    params.require(:user).permit(:email,:name,:surname, :header, :profile)
	  end
end
