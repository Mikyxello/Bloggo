class PostsController < ApplicationController

	before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy, :upvote, :downvote, :favourite, :unfavourite ]
	before_action :check_editor, only: [ :new, :create ]
	before_action :check_user, only: [ :edit, :update ]
	before_action :check_destroy, only: [ :destroy ]
	impressionist actions: [ :show ], unique: [ :impressionable_type, :impressionable_id, :session_hash ]
	
	def index
		@blog = Blog.find(params[:blog_id])
		@posts = @blog.posts.paginate(page: params[:page], per_page: 5)
	end

	def show
		@blog = Blog.find(params[:blog_id])
		@post = @blog.posts.find(params[:id])
		@related_posts = Post.where.not(id: @post.id).tagged_with(@post.tag_list, any: true).order(:cached_weighted_average => :desc, :cached_votes_total => :desc, :impressions_count => :asc).first(3)
		render 'show'
	end

	def new
		@blog = Blog.find(params[:blog_id])
		@post = @blog.posts.build
	end

	def edit
		@blog = Blog.find(params[:blog_id])
		@post = @blog.posts.find(params[:id])
	end

	def create
		@blog = Blog.find(params[:blog_id])
		@post = @blog.posts.create(post_params)
		@post.user = current_user

		if @post.save
			redirect_to blog_post_path(@blog, @post)
		else
			render 'new'
		end
	end

	def update
		@blog = Blog.find(params[:blog_id])
		@post = @blog.posts.find(params[:id])

		if params[:remove_file]
			@post.remove_file!
		end

		if @post.update(post_params)
			redirect_to blog_post_path(@blog, @post)
		else
			render 'edit'
		end
	end

	def destroy
		@blog = Blog.find(params[:blog_id])
		@post = @blog.posts.find(params[:id])
		@post.destroy

		if current_user.admin?
			redirect_to admin_panel_index_path
		else
			redirect_to blog_path(@blog)
		end
	end

	def upvote
		@blog = Blog.find(params[:blog_id])
		@post = @blog.posts.find(params[:id])
		respond_to do |format|
			if current_user.voted_up_on? @post
				format.html { redirect_back fallback_location: root_path }
				format.json { head :no_content }
				format.js { render :layout => false }
				@post.cached_votes_total = @post.cached_votes_total - 1
				@post.save
				@post.unliked_by current_user
			else
				format.html { redirect_back fallback_location: root_path }
				format.json { head :no_content }
				format.js { render :layout => false }
				@post.cached_votes_total = @post.cached_votes_total + 1
				@post.save
				@post.upvote_by current_user
			end
		end
	end
	
	def downvote
		@blog = Blog.find(params[:blog_id])
		@post = @blog.posts.find(params[:id])
		respond_to do |format|
			if current_user.voted_down_on? @post
				format.html { redirect_back fallback_location: root_path }
				format.json { head :no_content }
				format.js { render :layout => false }
				@post.cached_votes_total = @post.cached_votes_total - 1
				@post.save
				@post.undisliked_by current_user
			else
				format.html { redirect_back fallback_location: root_path }
				format.json { head :no_content }
				format.js { render :layout => false }
				@post.cached_votes_total = @post.cached_votes_total + 1
				@post.save
				@post.downvote_by current_user
			end
		end
	end

	def favourite
		@blog = Blog.find(params[:blog_id])
		@post = @blog.posts.find(params[:id])
		current_user.favorite(@post)

		respond_to do |format|
			format.html { redirect_back fallback_location: root_path }
			format.json { head :no_content }
			format.js { render :layout => false }
		end
	end

	def unfavourite
		@blog = Blog.find(params[:blog_id])
		@post = @blog.posts.find(params[:id])
		current_user.remove_favorite(@post)

		respond_to do |format|
			format.html { redirect_back fallback_location: root_path }
			format.json { head :no_content }
			format.js { render :layout => false }
		end
	end	


	private
	def post_params
		params.require(:post).permit(:title, :subtitle, :content, :tag_list, :file, :remove_file)
	end

	private
	def check_editor
		@blog = Blog.find(params[:blog_id])
		redirect_to blog_path(@blog) unless (@blog.user == current_user) || (@blog.editors == current_user.id)
	end

	private
	def check_user
		@blog = Blog.find(params[:blog_id])
		@post = @blog.posts.find(params[:id])
		redirect_to blog_path(@blog) unless @post.user == current_user
	end

	private
	def check_destroy
		@blog = Blog.find(params[:blog_id])
		@post = @blog.posts.find(params[:id])
		redirect_to blog_path(@blog) unless (current_user.admin?) || (@blog.user == current_user) || (@blog.editors == current_user.id) || (!@post.nil? && @post.user == current_user)
	end
end
