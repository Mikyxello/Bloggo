class PostsController < ApplicationController
	
	before_action :check_user, except: [ :show, :new, :create, :upvote, :downvote ]

	def new
		@blog = Blog.find(params[:blog_id])
		@post = @blog.posts.build
	end

	def edit
		@blog = Blog.find(params[:blog_id])
		@post = @blog.posts.find(params[:id])
	end

	def show
		@blog = Blog.find(params[:blog_id])
		@post = @blog.posts.find(params[:id])
		@related_posts = Post.tagged_with(@post.tag_list, any: true).last(3)
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

	def destroy
		@blog = Blog.find(params[:blog_id])
		@post = @blog.posts.find(params[:id])
		@post.destroy

		redirect_to blog_path(@blog)
	end

	def upvote
		@blog = Blog.find(params[:blog_id])
		@post = @blog.posts.find(params[:id])
		@post.upvote_by current_user

		redirect_back fallback_location: @post
	end  

	def downvote
		@blog = Blog.find(params[:blog_id])
		@post = @blog.posts.find(params[:id])
		@post.downvote_by current_user
		
		redirect_back fallback_location: @post
	end

	private
	def post_params
		params.require(:post).permit(:title, :subtitle, :content, :tag_list)
	end

	private
	def check_user
		@blog = Blog.find(params[:blog_id])
		@post = @blog.posts.find(params[:id])
		redirect_to blog_post_path(@blog, @post) unless @post.user == current_user
	end
end
