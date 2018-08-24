require 'rails_helper'

RSpec.describe SearchController, type: :controller do

  before(:each) do
    @owner = FactoryBot.create(:user)
		@user = FactoryBot.create(:user)
		@blog = FactoryBot.create(:blog, :user => @owner)
    @blog2 = FactoryBot.create(:blog, :user => @owner)
		@post = FactoryBot.create(:post, :user => @owner, :blog => @blog)

  end

  describe "GET #index" do

    context "with a valid question" do
      it "returns a success response" do
        get :index , params: {q: @blog.name, commit: 'Search'}
        expect(response).to be_successful
        expect(assigns(:blogs)).not_to be nil
        expect(assigns(:blogs)).not_to include(@blog2)
      end
    end

    context "with a invalid blog name" do
      it "returns an unsuccess response" do
        get :index, params: {q: "Questaèunaprova", commit: 'Search'}
        expect(response).to be_successful
        expect(assigns(:blogs)).to be_empty
        expect(assigns(:blogs)).not_to include(@blog)
        expect(assigns(:blogs)).not_to include(@blog2)
      end
    end




  end
end
