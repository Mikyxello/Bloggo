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

	def editors
		@blog = Blog.find(params[:id])
		@editors = Array.new()
		if @blog.editors.blank?
			redirect_to blog_path(@blog)
			return
		else
			@editors_array = @blog.editors.split("/").map(&:to_i)
			@editors_array.each do |editors|
				@editors << User.find(editors)
			end
		end
	end

	def add_editors
		@blog = Blog.find(params[:id])
		@user = User.find_by_email(params[:email])
		@posts = Post.where(blog_id: @blog)
		@shown_posts = @blog.posts.last(5)

		if @user.nil? || @user.id == @blog.user.id
			redirect_to blog_path(@blog)
			return
		end
		if @blog.editors.nil?
			@blog.editors = @user.id.to_s << "/"
		else
			@editors_array = @blog.editors.split("/").map(&:to_i)
			if @editors_array.include?(@user.id)
				redirect_to user_path
			else
				@blog.editors << @user.id.to_s << "/" 
			end
		end
		@blog.save
		redirect_to blog_path(@blog)
	end

	def remove_editors
		@blog = Blog.find(params[:id])
		@editors_array = @blog.editors.split("/").map(&:to_s)
		@new_editors = ""
		if @editors_array.include?(params[:user_id])
			@editors_array.delete(params[:user_id])
		else
			redirect_to blog_path(@blog)
			return
		end
		@editors_array.each do |editors|
			@new_editors << editors.to_s << "/"
		end
		@blog.editors = @new_editors
		@blog.save
		redirect_to blog_path(@blog)
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
			if current_user.role.to_s == "bloggoer"
				@blog = current_user.blogs.build
			else
				redirect_to '/'
			end
		else
			redirect_to '/'
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
