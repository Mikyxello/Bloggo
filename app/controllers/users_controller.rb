class UsersController < ApplicationController
  before_action :authenticate_user!

  def index
	  @user = current_user
		@blog = Blog.where(user_id: @user).last(5).reverse!
		end

 	def show
		@user = User.find(params[:id])
		@blog = Blog.where(user_id: @user)
 	end

  def create
    @user = User.create(user_params)
  end

 	private
 		def user_params
		    params.require(:user).permit(:email,:name,:surname)
	  end
end
