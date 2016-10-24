require 'open-uri'

class ForecastController < ApplicationController
  def coords_to_weather_form
    # Nothing to do here.
    render("forecast/coords_to_weather_form.html.erb")
  end

  def coords_to_weather
    @lat = params[:user_latitude]
    @lng = params[:user_longitude]

    # ==========================================================================
    # Your code goes below.
    # The latitude the user input is in the string @lat.
    # The longitude the user input is in the string @lng.
    # ==========================================================================

url = "https://api.darksky.net/forecast/6c549eac6d9c77d8b3c78af486322b43/#{@lat},#{@lng}"
raw_data = open(url).read
parsed_data = JSON.parse(raw_data)
currently = parsed_data["currently"]
minutely = parsed_data["minutely"]
hourly = parsed_data["hourly"]
daily = parsed_data["daily"]

    @current_temperature = currently["temperature"]

    @current_summary = currently["summary"]

    @summary_of_next_sixty_minutes = minutely["summary"]

    @summary_of_next_several_hours = hourly["summary"]

    @summary_of_next_several_days = daily["summary"]

    render("forecast/coords_to_weather.html.erb")
  end
end
