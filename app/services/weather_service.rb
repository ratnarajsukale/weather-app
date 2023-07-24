class WeatherService
  def initialize(city)
    @city = city
  end

  def call
    return nil unless @city.present?

    #Weather_api_key is directly added to URl instead of using rails credentials to simplify the cloning process.
    url = "https://api.openweathermap.org/data/2.5/weather?q=#{@city}&units=metric&appid=1ef7c85173ae7905c3b01c9c240c491b"
    response = Net::HTTP.get(URI(url))
    JSON.parse(response)
  rescue => e
    Rails.logger.error("WeatherService: #{e.message}")
    nil
  end
end
