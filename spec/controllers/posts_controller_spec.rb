require 'rails_helper'

RSpec.describe PostsController, type: :controller do

	before(:each) do
		@user = FactoryBot.create(:user)
		@blog = FactoryBot.create(:blog, :user => @user)
		@valid_attributes = FactoryBot.attributes_for(:post, :blog => @blog, :user => @user)
	end

	describe "GET #show" do
		context "with valid id" do
			it "returns a success response" do
				post = @blog.posts.create! @valid_attributes
				get :show, params: {blog_id: @blog.to_param, id: post.to_param}
				expect(response).to be_successful
			end
		end

		context "with invalid id" do
			it "shows error page" do
				id = Post.count + 1
				expect{get :show, params: {blog_id: @blog.to_param, id: id}}.not_to raise_error
				expect(response).to render_template(:file => "#{Rails.root}/public/404.html")
			end
		end
	end
end
