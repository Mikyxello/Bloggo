RSpec.describe UsersController, :type => :controller do

  before(:each) do
		@user = FactoryBot.create(:user)
    @test_user = FactoryBot.create(:user, :banned => false, :role => :user)
    @admin_user = FactoryBot.create(:user, :role => :admin)
	end

  describe "GET #index" do
    context "user is logged in" do
      it "renders user profile page" do
        allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@user)
        get :index
        expect(response).to be_successful
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
        expect(response).to be_successful
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

  end

  describe "GET users#change_status/:user_id" do
    context "user is logged in and is an admin" do
      it "change the users status and redirects to admin_panel_index_path" do
        allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@admin_user)
        expect(@admin_user.admin?).to be true
        expect(@test_user.banned?).to be false
        get :change_status, params: {:id => @test_user.id}
        @test_user.reload
        expect(@test_user.banned?).to be true
        expect(response).to redirect_to(admin_panel_index_path)
      end
    end

    context "user is logged in but is not an admin" do
      it "redirects to root path " do
        allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@user)
        get :change_status, params: {:id => @test_user.id}
        expect(response).not_to be_successful
      end
    end

    context "user is not logged in" do
      it "redirects to login page" do
        allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
        allow(controller).to receive(:current_user).and_return(nil)
        get :change_status, params: {:id => @test_user.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "POST #destroy" do
    context "user logged in is admin" do
      it "delete the users status and redirects to admin_panel_index_path" do
        allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@admin_user)
        expect { post :destroy, params: {:id => @test_user.id} }.to change{User.count}.by(-1)
      end
    end

    context "user logged in not admin" do
      it "redirects to root path " do
        allow(controller).to receive(:authenticate_user!).and_return(true)
				allow(controller).to receive(:current_user).and_return(@user)
        post :destroy, params: {:id => @test_user.id}
        expect(response).not_to be_successful
      end
    end

    context "user not logged in" do
      it "redirects to login page" do
        allow(request.env['warden']).to receive(:authenticate!).and_throw(:warden, {:scope => :user})
        allow(controller).to receive(:current_user).and_return(nil)
        post :destroy, params: {:id => @test_user.id}
        expect(response).to redirect_to(new_user_session_path)
      end
    end
  end

  describe "POST #create" do
    
  end
end
