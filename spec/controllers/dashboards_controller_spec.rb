require 'rails_helper'

RSpec.describe DashboardsController, type: :controller do
    let(:user) { User.create(email: "test@example.com", password: "password", password_confirmation: "password") }
  
    before do
      # Log in the user before each test
      session[:user_id] = user.id
    end
  
    describe "GET #show" do
      it "renders the 'show' template" do
        get :show
        expect(response).to render_template(:show)
      end
    end
  
    describe "PATCH #update" do
      context "with valid city parameter" do
        let(:valid_params) { { city: "London" } }
  
        before do
          # Stub the WeatherService call to return a successful response
          allow_any_instance_of(WeatherService).to receive(:call).and_return({
            'cod' => 200,
            'name' => 'London',
            'main' => {
              'temp' => 18.5,
              'humidity' => 70
            }
          })
        end
  
        it "calls the WeatherService with the provided city" do
          expect(WeatherService).to receive(:new).with("London").and_call_original
  
          patch :update, params: valid_params
        end
  
        it "assigns the weather data to @weather_data" do
          patch :update, params: valid_params
          expect(assigns(:weather_data)).to be_present
          expect(assigns(:error)).to be_nil
        end
  
        it "renders the 'show' template" do
          patch :update, params: valid_params
          expect(response).to render_template(:show)
        end
      end
  
      context "with invalid city parameter" do
        let(:invalid_params) { { city: "InvalidCity" } }
  
        before do
          # Stub the WeatherService call to return an error response
          allow_any_instance_of(WeatherService).to receive(:call).and_return({
            'cod' => 404,
            'message' => 'City not found'
          })
        end
  
        it "calls the WeatherService with the provided city" do
          expect(WeatherService).to receive(:new).with("InvalidCity").and_call_original
  
          patch :update, params: invalid_params
        end
  
        it "assigns the error message to @error" do
          patch :update, params: invalid_params
          expect(assigns(:weather_data)).to be_nil
          expect(assigns(:error)).to eq('City not found')
        end
  
        it "renders the 'show' template" do
          patch :update, params: invalid_params
          expect(response).to render_template(:show)
        end
      end
  
      context "without city parameter" do
        it "does not call the WeatherService" do
          expect(WeatherService).not_to receive(:new)
  
          patch :update
        end
  
        it "does not assign any weather data or error" do
          patch :update
          expect(assigns(:weather_data)).to be_nil
          expect(assigns(:error)).to be_nil
        end
  
        it "renders the 'show' template" do
          patch :update
          expect(response).to render_template(:show)
        end
      end
    end
  end
  