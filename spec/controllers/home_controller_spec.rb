require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  before(:each) do
		@user = FactoryBot.create(:user)
  end

  describe "GET index" do


    context "searched an empty word" do
      it "renders the search page without results" do
        get :index
        expect(response).to be_successful
      end
    end


  end
end
