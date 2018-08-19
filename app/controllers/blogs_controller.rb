class BlogsController < ApplicationController

	before_action :check_user, except: [ :index, :show, :new, :create, :follow, :unfollow, :favourite, :unfavourite]
	impressionist actions: [:show], unique: [:impressionable_type, :impressionable_id, :session_hash]

	def index
		@blogs = Blog.all
	end

	def search
		@blogs = Blog.search(params)
	end

	def show
		@blog = Blog.find(params[:id])
		@posts = Post.where(blog_id: @blog)
		@filter = "Most Recent"
		@shown_posts = @blog.posts.last(5)
		render 'show'
	end

	def add_editors
		@blog = Blog.find(params[:id])
		@user = User.find(params[:user_id])
		@posts = Post.where(blog_id: @blog)
		@shown_posts = @blog.posts.last(5)
		@blog.editors = @user.id
		@blog.save
		render 'show'
	end

	def remove_editors
		@blog = Blog.find(params[:id])
		@user = User.find(params[:user_id])
		if (@blog.editors.includes(@user.id))
			@blog.editors.remove(@user.id)
		end
		render 'show'
	end

	def follow
		@blog = Blog.find(params[:id])
		current_user.follow(@blog)
		show
	end

	def unfollow
		@blog = Blog.find(params[:id])
		current_user.stop_following(@blog)
		show
	end

	def favourite
		@blog = Blog.find(params[:id])
		current_user.favorite(@blog)
		show
	end

	def unfavourite
		@blog = Blog.find(params[:id])
		current_user.remove_favorite(@blog)
		show
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

	def edit
		@blog = Blog.find(params[:id])
	end

	def update
		@blog = Blog.find(params[:id])

		if @blog.update(blog_params)
			redirect_to @blog
		else
			render 'edit'
		end
	end

	def new
		if user_signed_in?
			@blog = current_user.blogs.build
		else
			render 'index'
		end
	end

	def destroy
		@blog = Blog.find(params[:id])
		@blog.destroy

		if current_user.admin?
			redirect_to admin_panel_index_path
		else
			redirect_to blogs_path
		end
	end

	def change_suspended
		@blog = Blog.find(params[:id])

		if current_user.admin?
			if @blog.suspended == true
				@blog.suspended = false
			else
				@blog.suspended = true
			end
		end
		@blog.save
		redirect_to admin_panel_index_path
	end

	def create
		@blog = current_user.blogs.build(blog_params)

		if @blog.save
			redirect_to @blog
		else
			render 'new'
		end
	end

	private
	def blog_params
		params.require(:blog).permit(:name, :description, :editors, :header, :profile)
	end

	private
	def check_user
		@blog = Blog.find(params[:id])
		redirect_to blog_path(@blog) unless @blog.user == current_user
	end

end
