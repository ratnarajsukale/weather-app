require "rails_helper"

RSpec.describe RegistrationsController, type: :controller do
  describe "GET #new" do
    it "assigns a new User instance to @user" do
      get :new
      expect(assigns(:user)).to be_a_new(User)
    end

    it "renders the 'new' template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    context "with valid parameters" do
      let(:valid_params) do
        {
          user: {
            email: "test@example.com",
            password: "password",
            password_confirmation: "password"
          }
        }
      end

      it "creates a new user" do
        expect {
          post :create, params: valid_params
        }.to change(User, :count).by(1)
      end

      it "sets the user_id in the session" do
        post :create, params: valid_params
        expect(session[:user_id]).to eq(User.last.id)
      end

      it "redirects to the root path with a success notice" do
        post :create, params: valid_params
        expect(response).to redirect_to(root_path)
      end
    end

    context "with invalid parameters" do
      let(:invalid_params) do
        {
          user: {
            email: "invalid_email",
            password: "password",
            password_confirmation: "different_password"
          }
        }
      end

      it "does not create a new user" do
        expect {
          post :create, params: invalid_params
        }.not_to change(User, :count)
      end

      it "renders the 'new' template with unprocessable_entity status" do
        post :create, params: invalid_params
        expect(response).to render_template(:new)
      end
    end
  end
end
