# app/controllers/weather_controller.rb
require 'open_weather'

class WeatherController < ApplicationController
  def weather
	options = { units: params[:units], APPID: params[:key] }
	puts params[:cities]
	city_results = []
	max = -1000
	min = 1000
	params[:cities].each { |city|
		puts "requesting: " + city
		results = OpenWeather::Current.city(city, options)
		puts results
		temp = results['main']['temp']
		if temp > max 
			max = temp
		end
		if temp < min
			min = temp
		end
		city_results << City.new(city, temp)
	}
	
	sorted_results = city_results.sort_by { |city| [city.temperature, city.name] }
	grouped_results = sorted_results.group_by { |city| city.temperature }
	puts "groups"
	puts grouped_results
	@message = Weather.new(city_results, grouped_results[min][0].name, grouped_results[max][0].name)
  end
end