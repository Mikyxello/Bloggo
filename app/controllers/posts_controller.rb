class PostsController < ApplicationController
	def create
		@blog = Blog.find(params[:blog_id])
		@post = @blog.posts.create(post_params)
		redirect_to blog_path(@blog)
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
