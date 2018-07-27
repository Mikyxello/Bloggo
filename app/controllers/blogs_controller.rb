class BlogsController < ApplicationController

	before_action :check_user, except: [ :show, :new, :create]

	def index
		@blogs = if params[:blog]
			Blog.where('name LIKE ?',"%#{params[:blog]}%")
		else
			Blog.all
		end
	end

	def show
		@blog = Blog.find(params[:id])
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
		@blog = current_user.blogs.build
	end

	def destroy
		@blog = Blog.find(params[:id])
		@blog.destroy

		redirect_to blogs_path
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
