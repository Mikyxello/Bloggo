class CommentsController < ApplicationController

	before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]
	before_action :check_editor, only: [ :destroy ]
	before_action :check_user, only: [ :edit, :update, :destroy ]
	
	def new
		@post = Post.find(params[:post_id])
		@comment = @post.comments.build(:parent_id => params[:parent_id])
	end

	def edit
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
	end

	def update
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])

		if @comment.update(comment_params)
			redirect_to blog_post_path(@post.blog, @post)
		else
			render 'edit'
		end
	end

	def create
		@post = Post.find(params[:post_id])
		@comment = @post.comments.create(comment_params)
		@comment.user = current_user

		if @comment.save
			redirect_to blog_post_path(@post.blog, @post)
		else
			render 'new'
		end
	end

	def destroy
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy

		redirect_to blog_post_path(@post.blog, @post)
	end

	private
	def comment_params
		params.require(:comment).permit(:parent_id, :content)
	end

	private
	def check_editor
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		redirect_to blog_post_path(@post.blog, @post) unless ([@comment.user, @post.user, @post.blog.user].include? current_user) || (@post.blog.editors == current_user.id)
	end

	private
	def check_user
		@post = Post.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		redirect_to blog_post_path(@post.blog, @post) unless @comment.user == current_user
	end
end
