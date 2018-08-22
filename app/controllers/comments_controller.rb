class CommentsController < ApplicationController

	before_action :authenticate_user!, only: [ :new, :create, :edit, :update, :destroy ]
	before_action :check_user, only: [ :edit, :update ]
	before_action :check_destroy, only: [ :destroy ]
	
	def new
		@post = Post.friendly.find(params[:post_id])
		@comment = @post.comments.build(:parent_id => params[:parent_id])
	end

	def edit
		@post = Post.friendly.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
	end

	def update
		@post = Post.friendly.find(params[:post_id])
		@comment = @post.comments.find(params[:id])

		if @comment.update(comment_params)
			redirect_to blog_post_path(@post.blog, @post)
		else
			render 'edit'
		end
	end

	def create
		@post = Post.friendly.find(params[:post_id])
		@comment = @post.comments.create(comment_params)
		@comment.user = current_user

		if @comment.save
			redirect_to blog_post_path(@post.blog, @post)
		else
			render 'new'
		end
	end

	def destroy
		@post = Post.friendly.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		@comment.destroy

		redirect_to blog_post_path(@post.blog, @post)
	end

	private
	def comment_params
		params.require(:comment).permit(:parent_id, :content)
	end

	private
	def check_user
		@post = Post.friendly.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		redirect_to blog_post_path(@post.blog, @post) unless @comment.user == current_user
	end

	private
	def check_destroy
		@post = Post.friendly.find(params[:post_id])
		@comment = @post.comments.find(params[:id])
		redirect_to blog_post_path(@post.blog, @post) unless ([@post.user, @post.blog.user].include? current_user) || (@post.blog.editors == current_user.id) || (current_user.admin?) || (!@comment.nil? && @comment.user == current_user) 
	end
end
