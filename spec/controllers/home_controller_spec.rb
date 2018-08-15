require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  before(:each) do
		@user = FactoryBot.create(:user)
  end

  describe "GET index" do
    context "user logged in" do
      it "renders the homepage" do
        get :index
        expect(response).to be_success
      end
    end
  end
end
