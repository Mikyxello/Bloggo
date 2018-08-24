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
				expect(controller.user_signed_in?).to be false
				get :new, params: {:blog_id => @blog.id, :post_id => @post.id}
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
				get :edit, params: {:blog_id => @blog.id, :post_id => @post.id, :id => @comment.id}
				expect(response).to be_successful
			end
		end

		context "with invalid user" do
			it "returns a success response" do
				allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@user)
				get :edit, params: {:blog_id => @blog.id, :post_id => @post.id, :id => @comment.id}
				expect(response).not_to be_successful
				expect(response).to redirect_to(blog_post_path(@blog, @post))
			end
		end

		context "with not logged user" do
			it "returns a success response" do
				expect(controller.user_signed_in?).to be false
				get :edit, params: {:blog_id => @blog.id, :post_id => @post.id, :id => @comment.id}
				expect(response).to redirect_to(new_user_session_path)
				expect(response).not_to be_successful
			end
		end
	end

	describe "POST #create" do
		context "with valid params" do
			it "creates a new Comment" do
				allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@owner)
				expect { post :create, params: {blog_id: @blog.id, post_id: @post.id, comment: @comment_attr} }.to change(Comment, :count).by(1)
				expect(response).to redirect_to(blog_post_path(@blog, @post))
			end
		end

		context "with valid params and parent id" do
			it "creates a new Reply" do
				allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@owner)
				@comment_attr[:parent_id] = @comment
				expect { post :create, params: {blog_id: @blog.id, post_id: @post.id, comment: @comment_attr} }.to change(Comment, :count).by(1)
				expect(response).to redirect_to(blog_post_path(@blog, @post))
				expect(assigns(:comment).parent).to eql @comment
				expect(assigns(:comment).content).to eql @comment_attr[:content]
			end
		end
		
		context "with not logged user" do
			it "returns a unsuccess response" do
				expect(controller.user_signed_in?).to be false
				expect{ post :create, params: {:blog_id => @blog.id, post_id: @post.id, comment: @comment_attr} }.not_to change(Comment, :count)
				expect(response).to redirect_to(new_user_session_path)
				expect(response).not_to be_successful
			end
		end
	end

	describe "PUT #update" do
		let!(:new_attr) { FactoryBot.attributes_for(:comment) }
		context "with valid user" do
			it "allows a comment to be updated" do
				allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@owner)
				put :update, params: {:blog_id => @blog.id, :post_id => @post.id, :id => @comment.id, :comment => new_attr}
				@comment.reload
				expect(response).to redirect_to(blog_post_path(@blog, @post))
				expect(@comment.content).to eql new_attr[:content]
			end
		end

		context "with invalid user" do
			it "not allows a comment to be updated" do
				allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@user)
				put :update, params: {:blog_id => @blog.id, :post_id => @post.id, :id => @comment.id, :comment => new_attr}
				@comment.reload
				expect(response).to redirect_to(blog_post_path(@blog, @post))
				expect(@comment.content).not_to eql new_attr[:content]
			end
		end

		context "with not logged user" do
			it "not allows a comment to be updated" do
				expect(controller.user_signed_in?).to be false
				put :update, params: {:blog_id => @blog.id, :post_id => @post.id, :id => @comment.id, :comment => new_attr}
				@comment.reload
				expect(response).to redirect_to(new_user_session_path)
				expect(@comment.content).not_to eql new_attr[:content]
			end
		end
	end

	describe "DELETE #destroy" do
		context "with valid user" do
			it "allows to destroy the requested comment" do
				allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@owner)
				expect { delete :destroy, params: {:blog_id => @blog.id, :post_id => @post.id, :id => @comment.id} }.to change(Comment, :count).by(-1)
				expect(response).to redirect_to(blog_post_path(@blog, @post))
			end
		end

		context "with invalid user" do
			it "not allows to destroy the requested comment" do
				allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@user)
				comment = @post.comments.create! @comment_attr
				expect { delete :destroy, params: {:blog_id => @blog.id, :post_id => @post.id, :id => comment.id} }.not_to change(Comment, :count)
				expect(response).to redirect_to(blog_post_path(@blog, @post))
			end
		end

		context "with not logged user" do
			it "not allows to destroy the requested comment" do
				expect(controller.user_signed_in?).to be false
				expect { delete :destroy, params: {:blog_id => @blog.id, :post_id => @post.id, :id => @comment.id} }.not_to change(Comment, :count)
				expect(response).to redirect_to(new_user_session_path)
				expect(response).not_to be_successful
			end
		end
	end
end

