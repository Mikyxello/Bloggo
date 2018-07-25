class PostsController < ApplicationController
	
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

	private
	def post_params
		params.require(:post).permit(:title, :subtitle, :content)
	end
end
