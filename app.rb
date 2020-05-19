require "sinatra"
require "sinatra/reloader"
require "httparty"
require 'open-uri'
def view(template); erb template.to_sym; end

get "/" do
  ### Get the weather
  # Bali weather
  lat = -8.5858
  long = 118.7811

  units = "imperial" # or metric, whatever you like
  key = "8ecb3366c20922d16e101245739fef2d" # replace this with your real OpenWeather API key

  # construct the URL to get the API data (https://openweathermap.org/api/one-call-api)
  url = "https://api.openweathermap.org/data/2.5/onecall?lat=-8.5858&lon=118.7811&units=#{units}&appid=#{key}"

  # make the call
  @forecast = HTTParty.get(url).parsed_response.to_hash

puts "It is currently #{@forecast["current"]["temp"]} degrees and #{@forecast["current"]["weather"][0]["description"]}"
puts "Extended forecast:"
day_number = 1
for day in @forecast["daily"]
   puts "On day #{day_number}, A high of #{day["temp"]["max"]} and #{day["weather"][0]["description"]}"
   day_number = day_number + 1
end

view "news"
  ### Get the news

## beginning to now get the news
key2 = "bb1e42b83f094c579178d96b912385c6"

url2 = "https://newsapi.org/v2/top-headlines?country=id&apiKey=#{key2}"
news = HTTParty.get(url2).parsed_response.to_hash

puts "Today's top stories are #{news["articles"]["source"]["name"]}"
puts news["articles"]["description"]
puts news["articles"]["url"]

end

# news is now a Hash you can pretty print (pp) and parse for your output
