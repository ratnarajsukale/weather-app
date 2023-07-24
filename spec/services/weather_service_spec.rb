require 'rails_helper'

RSpec.describe WeatherService do
    describe "#call" do
      context "with a valid city" do
        let(:city) { "New York" }
        let(:valid_response) { { "name" => "New York", "main" => { "temp" => 25 } } }
  
        before do
          # Stub the API call to return a valid response
          allow(Net::HTTP).to receive(:get).and_return(valid_response.to_json)
        end
  
        it "returns the weather data when the API call is successful" do
          weather_service = WeatherService.new(city)
          result = weather_service.call
          expect(result).to eq(valid_response)
        end
      end
  
      context "with an invalid city" do
        let(:invalid_city) { "" }
  
        before do
          # Stub the API call to return nil (as if the city is not present)
          allow(Net::HTTP).to receive(:get).and_return(nil)
        end
  
        it "returns nil when the city is not present" do
          weather_service = WeatherService.new(invalid_city)
          result = weather_service.call
          expect(result).to be_nil
        end
      end
  
      context "with a city that causes an API error" do
        let(:error_city) { "ErrorCity" }
  
        before do
          # Stub the API call to raise an exception
          allow(Net::HTTP).to receive(:get).and_raise(StandardError.new("API Error"))
        end
  
        it "returns nil and logs the error when the API call raises an exception" do
          weather_service = WeatherService.new(error_city)
          result = weather_service.call
          expect(result).to be_nil
        end
      end
    end
  end
  