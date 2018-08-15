require 'rails_helper'

RSpec.describe AdminPanelController, type: :controller do

  before(:each) do
		@user = FactoryBot.create(:user)
    @admin_user = FactoryBot.create(:user, :role => :admin)
  end

  describe "GET #index" do
    context "user is an admin" do
      it "renders the admin panel" do
        allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@admin_user)
        get :index
        expect(response).to be_success
      end
    end

    context "user is not an  admin" do
      it "renders the home page" do
        allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@user)
        get :index
        expect(response).to redirect_to(root_path)
      end
    end

    context "user is not logged in" do
      it "renders the home page" do
        allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
        allow(controller).to receive(:current_user).and_return(nil)
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

end
