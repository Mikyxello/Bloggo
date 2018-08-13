require 'rails_helper'

RSpec.describe PostsController, type: :controller do

	before(:each) do
		@owner = FactoryBot.create(:user)
		@blog = FactoryBot.create(:blog, :user => @owner)
		@post_attr = FactoryBot.attributes_for(:post, :blog => @blog, :user => @owner)
	end

	describe "GET #show" do
		context "with valid id" do
			it "returns a success response" do
				post = @blog.posts.create! @post_attr
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

	describe "GET #new" do
		context "with valid user" do
			it "returns a success response" do
				allow(controller).to receive(:current_user).and_return(@owner)
				get :new, params: {:blog_id => @blog.id}
				expect(response).to be_successful
			end
		end

		context "with invalid user" do
			it "go back to blog page" do
				@user = FactoryBot.create(:user)
				allow(controller).to receive(:current_user).and_return(@user)
				get :new, params: {:blog_id => @blog.id}
				expect(response).to redirect_to(@blog)
			end
		end
	end

	describe "POST #create" do
		context "with valid params" do
			it "creates a new Post" do
				allow(controller).to receive(:current_user).and_return(@owner)
				expect {
					post :create, params: {blog_id: @blog.id, post: @post_attr}
				}.to change(Post, :count).by(1)
			end

			it "redirects to the created post" do
				allow(controller).to receive(:current_user).and_return(@owner)
				post :create, params: {blog_id: @blog.id, post: @post_attr}
				expect(response).to redirect_to(blog_post_path(@blog, Post.last))
			end
		end
		context "with invalid user" do
			it "returns a unsuccess response" do
				@user = FactoryBot.create(:user)
				allow(controller).to receive(:current_user).and_return(@user)
				post :create, params: {:blog_id => @blog.id, post: @post_attr}
				expect(response).not_to be_successful
			end

			it "redirects to the blog page" do
				@user = FactoryBot.create(:user)
				allow(controller).to receive(:current_user).and_return(@user)
				post :create, params: {:blog_id => @blog.id, post: @post_attr}
				expect(response).to redirect_to(@blog)
			end
		end
	end
end
