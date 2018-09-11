require 'rails_helper'

RSpec.describe BlogsController, type: :controller do
  before(:each) do
    @owner = FactoryBot.create(:user, :is_bloggoer)
		@user = FactoryBot.create(:user)
		@blog = FactoryBot.create(:blog, :user => @owner)
    @blog2 = FactoryBot.create(:blog, :user => @owner, :editors => "omg@gmail.com")
		@post = FactoryBot.create(:post, :user => @owner, :blog => @blog)
    @post2 = FactoryBot.create(:post, :user => @owner, :blog => @blog)
  end

  describe "GET #new" do

    context "with logged user" do
      it "returns a redirect to index" do
        allow(controller).to receive(:authenticate_user!).and_return(true)
        allow(controller).to receive(:current_user).and_return(@user)
        get :new, params: {:blog_id => @blog.id}
        expect(response).to redirect_to("/")  
      end
    end

    context "with not logged user" do
      it "returns a redirect to index" do
        allow(controller).to receive(:authenticate_user!).and_return(false)
        get :new, params: {:blog_id => @blog.id}
        expect(response).to redirect_to("/")  
      end
    end

    context "with logged bloggoer" do
      it "returns a success response" do
        allow(controller).to receive(:authenticate_user!).and_return(true)
        allow(controller).to receive(:current_user).and_return(@owner)
        get :new, params: {:blog_id => @blog.id}
        expect(response).to be_successful
      end
    end
  end
end
