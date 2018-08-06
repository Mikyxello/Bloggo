class BlogsController < ApplicationController

	before_action :check_user, except: [ :index, :show, :new, :create, :follow, :unfollow ]
	impressionist actions: [:show], unique: [:impressionable_type, :impressionable_id, :session_hash]

	def index
		@blogs = if params[:blog]
			Blog.where('name LIKE ?',"%#{params[:blog]}%")
		else
			Blog.all
		end
	end

	def show
		@blog = Blog.find(params[:id])
		@posts = Post.where(blog_id: @blog)
		@filter = "Most Recent"
		@shown_posts = @blog.posts.last(5)
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

	def visited_view
		@filter == "Most Visited"
		@shown_posts = @blog.posts.order(:counter).last(5)
		render 'show'
	end

	def recent_view
		@filter = "Most Recent"
		@shown_posts = @blog.posts.last(5)
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
		params.require(:blog).permit(:name, :description)
	end

	private
	def check_user
		@blog = Blog.find(params[:id])
		redirect_to blog_path(@blog) unless @blog.user == current_user
	end

end
