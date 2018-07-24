class CommentsController < ApplicationController
	def new
		@post = Post.find(params[:post_id])
		@comment = @post.comments.build
	end

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(comment_params)

		if @comment.save
			redirect_to blog_path(@post.blog)
		else
			render 'new'
		end
	end

	def edit
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
	end

	def update
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])

		if @comment.update(comment_params)
			redirect_to blog_path(@post.blog)
		else
			render 'edit'
		end
	end

	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy

		redirect_to blog_path(@post.blog)
	end

	private
	def comment_params
		params.require(:comment).permit(:content)
	end
end
