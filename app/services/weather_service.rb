class WeatherService

  def initialize(city)
    @city = city
  end

  def call
    return nil unless @city.present?

    url = "https://api.openweathermap.org/data/2.5/weather?q=#{@city}&units=metric&appid=#{Rails.application.credentials.dig(:weather, :api_key)}"
    response = Net::HTTP.get(URI(url))
    JSON.parse(response)
  rescue StandardError => e
    Rails.logger.error("WeatherService: #{e.message}")
    nil
  end

end
  