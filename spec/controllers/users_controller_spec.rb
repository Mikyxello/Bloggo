RSpec.describe UsersController, :type => :controller do

  before(:each) do
		@user = FactoryBot.create(:user)
    @test_user = FactoryBot.create(:user)
	end

  describe "GET #index" do
    context "user is logged in" do
      it "renders user profile page" do
        allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@user)
        get :index
        expect(response).to be_success
      end
    end

    context "user is not logged in" do
      it "redirects to login page" do
        allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
        allow(controller).to receive(:current_user).and_return(nil)
        get :index
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #show/:user_id" do
    context "user is logged in" do
      it "renders user profile page" do
        allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@user)
        get :index, params: {:user_id => @test_user.id}
        expect(response).to be_success
      end
    end

    context "user is not logged in" do
      it "redirects to login page" do
        allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
        allow(controller).to receive(:current_user).and_return(nil)
        get :index, params: {:user_id => @test_user.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #upgrade" do
    context "user is logged in" do
      it "renders user profile page" do
        allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@user)
        get :index, params: {:user_id => @test_user.id}
        expect(response).to be_success
      end
    end

    context "user is already upgraded" do
      it "renders user profile page" do
        allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@user)
        get :index, params: {:user_id => @test_user.id}
        expect(response).to be_success
      end
    end

    context "user is not logged in" do
      it "redirects to login page" do
        allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
        allow(controller).to receive(:current_user).and_return(nil)
        get :index, params: {:user_id => @test_user.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "user is not logged in" do
      it "redirects to login page" do
        allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
        allow(controller).to receive(:current_user).and_return(nil)
        get :index, params: {:user_id => @test_user.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "GET #change_status" do

  end

  describe "POST #destroy" do

  end

  describe "POST #create" do

  end
end
