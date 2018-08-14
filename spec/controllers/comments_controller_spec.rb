require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
	before(:each) do
		@owner = FactoryBot.create(:user)
		@user = FactoryBot.create(:user)
		@blog = FactoryBot.create(:blog, :user => @owner)
		@post = FactoryBot.create(:post, :user => @owner, :blog => @blog)
		@comment = FactoryBot.create(:comment, :post => @post, :user => @owner)
		@comment_attr = FactoryBot.attributes_for(:comment, :post => @post, :user => @owner)
	end

	describe "GET #new" do
		context "with logged user" do
			it "returns a success response" do
				allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@user)
				get :new, params: {:blog_id => @blog.id, :post_id => @post.id}
				expect(response).to be_successful
			end
		end

		context "with not logged user" do
			it "go back to blog page" do
				expect(@user).not_to be_logged_in
				allow(controller).to receive(:authenticate_user!).and_return(false)
				get :new, params: {:blog_id => @blog.id, :post_id => @post.id}
				expect(response).to redirect_to(blog_post_path(@blog, @post))
				expect(response).not_to be_successful
			end
		end
	end
end
