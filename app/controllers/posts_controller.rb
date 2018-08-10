class PostsController < ApplicationController

	before_action :authenticate_user!, only: [ :upvote, :downvote ]
	before_action :check_editor, only: [ :new, :create, :destroy ]
	before_action :check_user, only: [ :edit, :update, :destroy ]
	before_action :check_admin, only: [ :destroy ]
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

	def favourite
		@blog = Blog.find(params[:blog_id])
		@post = @blog.posts.find(params[:id])
		current_user.favorite(@post)
		show
	end

	def unfavourite
		@blog = Blog.find(params[:blog_id])
		@post = @blog.posts.find(params[:id])
		current_user.remove_favorite(@post)
		show
	end	

	def update
		@blog = Blog.find(params[:blog_id])
		@post = @blog.posts.find(params[:id])

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
				format.html { redirect_to :back }
				format.json { head :no_content }
				format.js { render :layout => false }
				@post.cached_votes_total = @post.cached_votes_total - 1
				@post.save
				@post.unliked_by current_user
			else
				format.html { redirect_to :back }
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
				format.html { redirect_to :back }
				format.json { head :no_content }
				format.js { render :layout => false }
				@post.cached_votes_total = @post.cached_votes_total - 1
				@post.save
				@post.undisliked_by current_user
			else
				format.html { redirect_to :back }
				format.json { head :no_content }
				format.js { render :layout => false }
				@post.cached_votes_total = @post.cached_votes_total + 1
				@post.save
				@post.downvote_by current_user
			end
		end
	end

	private
	def post_params
		params.require(:post).permit(:title, :subtitle, :content, :tag_list, :file)
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
	def check_admin
		@blog = Blog.find(params[:blog_id])
		redirect_to blog_path(@blog) unless current_user.admin?
	end
end
