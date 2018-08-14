require 'rails_helper'

RSpec.describe PostsController, type: :controller do

	before(:each) do
		@owner = FactoryBot.create(:user)
		@user = FactoryBot.create(:user)
		@blog = FactoryBot.create(:blog, :user => @owner)
		@post = FactoryBot.create(:post, :user => @owner, :blog => @blog)
		@post_attr = FactoryBot.attributes_for(:post, :blog => @blog, :user => @owner)
	end

	describe "GET #index" do
		context "with valid id" do
			it "returns a success response" do
				get :index, params: {blog_id: @blog.id}
				expect(response).to be_successful
			end
		end

		context "with invalid id" do
			it "returns a unsuccess response" do
				id = Blog.count + 1
				get :index, params: {blog_id: id}
				expect(response).to render_template(:file => "#{Rails.root}/public/404.html")
				expect(response).not_to be_successful
			end
		end

		context "with not logged user" do
			it "returns a success response" do
				expect(controller.user_signed_in?).to be false
				get :index, params: {blog_id: @blog.id}
				expect(response).to be_successful
			end
		end
	end

	describe "GET #show" do
		context "with valid id" do
			it "returns a success response" do
				get :show, params: {blog_id: @blog.id, id: @post.id}
				expect(response).to be_successful
			end
		end

		context "with invalid id" do
			it "shows error page" do
				id = Post.count + 1
				expect{get :show, params: {blog_id: @blog.id, id: id}}.not_to raise_error
				expect(response).to render_template(:file => "#{Rails.root}/public/404.html")
			end
		end
	end

	describe "GET #new" do
		context "with valid user" do
			it "returns a success response" do
				allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@owner)
				get :new, params: {:blog_id => @blog.id}
				expect(response).to be_successful
			end
		end

		context "with invalid user" do
			it "go back to blog page" do
				allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@user)
				get :new, params: {:blog_id => @blog.id}
				expect(response).to redirect_to(@blog)
				expect(response).not_to be_successful
			end
		end

		context "with not logged user" do
			it "go to login page" do
				expect(controller.user_signed_in?).to be false
				get :new, params: {:blog_id => @blog.id}
				expect(response).to redirect_to(new_user_session_path)
				expect(response).not_to be_successful
			end
		end
	end

	describe "GET #edit" do
		context "with valid user" do
			it "returns a success response" do
				allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@owner)
				get :edit, params: {:blog_id => @blog.id, :id => @post.id}
				expect(response).to be_successful
			end
		end

		context "with invalid user" do
			it "go back to blog page" do
				allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@user)
				get :edit, params: {:blog_id => @blog.id, :id => @post.id}
				expect(response).to redirect_to(@blog)
			end
		end

		context "with not logged user" do
			it "go to login page" do
				expect(controller.user_signed_in?).to be false
				get :edit, params: {:blog_id => @blog.id, :id => @post.id}
				expect(response).to redirect_to(new_user_session_path)
				expect(response).not_to be_successful
			end
		end
	end

	describe "POST #create" do
		context "with valid params" do
			it "creates a new Post" do
				allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@owner)
				expect { post :create, params: {blog_id: @blog.id, post: @post_attr} }.to change(Post, :count).by(1)
				expect(response).to redirect_to(blog_post_path(@blog, Post.last))
			end
		end

		context "with invalid user" do
			it "returns a unsuccess response" do
				allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@user)
				expect{ post :create, params: {:blog_id => @blog.id, post: @post_attr} }.not_to change(Post, :count)
				expect(response).not_to be_successful
				expect(response).to redirect_to(@blog)
			end
		end

		context "with not logged user" do
			it "go to login page" do
				expect(controller.user_signed_in?).to be false
				expect{ post :create, params: {:blog_id => @blog.id, post: @post_attr} }.not_to change(Post, :count)
				expect(response).to redirect_to(new_user_session_path)
				expect(response).not_to be_successful
			end
		end
	end

	describe "PUT #update" do
		let!(:new_attr) { FactoryBot.attributes_for(:post) }
		context "with valid user" do
			it "allows a post to be updated" do
				allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@owner)
				put :update, params: {:blog_id => @blog.id, :id => @post.id, :post => new_attr}
				@post.reload
				expect(response).to redirect_to(blog_post_path(@blog, @post))
				expect(@post.title).to eql new_attr[:title]
				expect(@post.subtitle).to eql new_attr[:subtitle]
				expect(@post.content).to eql new_attr[:content]
			end
		end

		context "with invalid user" do
			it "not allows a post to be updated" do
				allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@user)
				put :update, params: {:blog_id => @blog.id, :id => @post.id, :post => new_attr}
				@post.reload
				expect(response).to redirect_to(@blog)
				expect(@post.title).not_to eql new_attr[:title]
				expect(@post.subtitle).not_to eql new_attr[:subtitle]
				expect(@post.content).not_to eql new_attr[:content]
			end
		end

		context "with not logged user" do
			it "go to login page" do
				expect(controller.user_signed_in?).to be false
				put :update, params: {:blog_id => @blog.id, :id => @post.id, :post => new_attr}
				@post.reload
				expect(@post.title).not_to eql new_attr[:title]
				expect(@post.subtitle).not_to eql new_attr[:subtitle]
				expect(@post.content).not_to eql new_attr[:content]
				expect(response).to redirect_to(new_user_session_path)
				expect(response).not_to be_successful
			end
		end
	end

	describe "DELETE #destroy" do
		context "with valid user" do
			it "allows to destroy the requested post" do
				allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@owner)
				expect { delete :destroy, params: {:blog_id => @blog.id, :id => @post.id} }.to change(Post, :count).by(-1)
				expect(response).to redirect_to(@blog)
			end
		end

		context "with invalid user" do
			it "not allows to destroy the requested post" do
				allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@user)
				post = @blog.posts.create! @post_attr
				expect { delete :destroy, params: {:blog_id => @blog.id, :id => post.id} }.not_to change(Post, :count)
				expect(response).to redirect_to(@blog)
			end
		end

		context "with not logged user" do
			it "go to login page" do
				expect(controller.user_signed_in?).to be false
				expect { delete :destroy, params: {:blog_id => @blog.id, :id => @post.id} }.not_to change(Post, :count)
				expect(response).to redirect_to(new_user_session_path)
				expect(response).not_to be_successful
			end
		end
	end

	describe "PUT #upvote" do
		context "with valid user" do
			it "allows to put upvote" do
				expect(@user.voted_on?(@post)).to be false
				allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@user)
				put :upvote, params: {:blog_id => @blog.id, :id => @post.id}
				expect(@user.voted_on?(@post)).to be true
			end

			it "allows to cancel vote" do
				allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@user)
				put :upvote, params: {:blog_id => @blog.id, :id => @post.id}
				expect(@user.voted_on?(@post)).to be true
				put :upvote, params: {:blog_id => @blog.id, :id => @post.id}
				expect(@user.voted_on?(@post)).to be false
			end
		end

		context "with not logged user" do
			it "do not allows to put upvote" do
				expect(controller.user_signed_in?).to be false
				put :upvote, params: {:blog_id => @blog.id, :id => @post.id}
				expect(response).to redirect_to(new_user_session_path)
			end
		end
	end

	describe "PUT #downvote" do
		context "with valid user" do
			it "allows to put downvote" do
				expect(@user.voted_on?(@post)).to be false
				allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@user)
				put :downvote, params: {:blog_id => @blog.id, :id => @post.id}
				expect(@user.voted_on?(@post)).to be true
			end

			it "allows to cancel vote" do
				allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@user)
				put :downvote, params: {:blog_id => @blog.id, :id => @post.id}
				expect(@user.voted_on?(@post)).to be true
				put :downvote, params: {:blog_id => @blog.id, :id => @post.id}
				expect(@user.voted_on?(@post)).to be false
			end
		end

		context "with not logged user" do
			it "do not allows to put downvote" do
				expect(controller.user_signed_in?).to be false
				put :downvote, params: {:blog_id => @blog.id, :id => @post.id}
				expect(response).to redirect_to(new_user_session_path)
			end
		end
	end

	describe "GET #favourite" do
		context "with logged user" do
			it "allows to favourite the post" do
				expect(@user.favorited? @post).to be false
				allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@user)
				get :favourite, params: {:blog_id => @blog.id, :id => @post.id}
			end
		end

		context "with not logged user" do
			it "do not allows to favourite the post" do
				expect(controller.user_signed_in?).to be false
				get :favourite, params: {:blog_id => @blog.id, :id => @post.id}
				expect(response).to redirect_to(new_user_session_path)
			end
		end
	end

	describe "GET #unfavourite" do
		context "with logged user" do
			it "allows to unfavourite the post" do
				allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@user)
				get :favourite, params: {:blog_id => @blog.id, :id => @post.id}
				expect(@user.favorited? @post).to be true
				get :unfavourite, params: {:blog_id => @blog.id, :id => @post.id}
				expect(@user.favorited? @post).to be false
			end
		end

		context "with not logged user" do
			it "do not allows to unfavourite the post" do
				expect(controller.user_signed_in?).to be false
				get :unfavourite, params: {:blog_id => @blog.id, :id => @post.id}
				expect(response).to redirect_to(new_user_session_path)
			end
		end
	end	
end
