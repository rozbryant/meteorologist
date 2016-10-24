require 'open-uri'

class MeteorologistController < ApplicationController
  def street_to_weather_form
    # Nothing to do here.
    render("meteorologist/street_to_weather_form.html.erb")
  end

  def street_to_weather
    @street_address = params[:user_street_address]
    @street_address_without_spaces = URI.encode(@street_address)


    # ==========================================================================
    # Your code goes below.
    # The street address the user input is in the variable @street_address.
    # A URL-safe version of the street address, with spaces and other illegal
    #   characters removed, is in the variable @street_address_without_spaces.
    # ==========================================================================
    geo_url = "http://maps.googleapis.com/maps/api/geocode/json?address=#{@street_address_without_spaces}"
    open geo_url
    raw_geo_data = open(geo_url).read
    parsed_geo_data = JSON.parse(raw_geo_data)
    results = parsed_geo_data["results"]
    first_geo = results[0]
    geometry = first_geo["geometry"]
    location = geometry["location"]
    
    @lat = location["lat"]
    @lng = location["lng"]

    weather_url = "https://api.darksky.net/forecast/6c549eac6d9c77d8b3c78af486322b43/#{@lat},#{@lng}"
    open weather_url
    raw_weather_data = open(weather_url).read
    parsed_weather_data = JSON.parse(raw_weather_data)
    currently = parsed_weather_data["currently"]
    minutely = parsed_weather_data["minutely"]
    hourly = parsed_weather_data["hourly"]
    daily = parsed_weather_data["daily"]

    @current_temperature = currently["temperature"]

    @current_summary = currently["summary"]

    @summary_of_next_sixty_minutes = minutely["summary"]

    @summary_of_next_several_hours = hourly["summary"]

    @summary_of_next_several_days = daily["summary"]

    render("meteorologist/street_to_weather.html.erb")
  end
end
