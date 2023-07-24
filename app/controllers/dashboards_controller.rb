class DashboardsController < ApplicationController
  before_action :set_current_user

  def show
  end

  def update
    if params[:city].present?

      weather_data = WeatherService.new(params[:city]).call

      if weather_data['cod'].to_i == 200
        @weather_data = weather_data
      else
        @error = weather_data['message']
      end
    end

    render :show
  end

end
