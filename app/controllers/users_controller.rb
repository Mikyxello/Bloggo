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
		@blogs = Blog.where(user_id: @user)
    @posts = Post.where(:user_id => @user.id)
    @filter = "Most Recent"
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

  def visited_view
    @filter = "Most Visited"
    @posts = Post.where(blog_id: @blog)
    @shown_posts = @blog.posts.order(:impressions_count).reverse.last(5)
    render 'show'
  end

  def recent_view
    @filter = "Most Recent"
    @posts = Post.where(blog_id: @blog)
    @shown_posts = @blog.posts.last(5)
    render 'show'
  end

  def reacted_view
    @filter = "Most Reacted"
    @posts = Post.where(blog_id: @blog)
    @shown_posts = @blog.posts.order(:cached_votes_total).reverse.last(5)
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
