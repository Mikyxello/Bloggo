class BlogsController < ApplicationController

	def index
		#@blogs = Blog.all
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
		@blog = Blog.new
	end

	def destroy
		@blog = Blog.find(params[:id])
		@blog.destroy

		redirect_to blogs_path
	end

	def create
		@blog = Blog.new(blog_params)

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

end
