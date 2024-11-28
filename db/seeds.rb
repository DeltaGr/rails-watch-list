# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
# db/seeds.rb

# db/seeds.rb
require 'open-uri'
require 'json'
require 'faker'

# Seed real movies from the TMDb API
base_url = 'https://tmdb.lewagon.com/movie/top_rated'
response = URI.open(base_url).read
movies_data = JSON.parse(response)['results']

movies_data.each do |movie_data|
  Movie.find_or_create_by(title: movie_data['title']) do |movie|
    movie.overview = movie_data['overview']
    movie.poster_url = "https://image.tmdb.org/t/p/original#{movie_data['poster_path']}"
    movie.rating = movie_data['vote_average']
  end
end

# Seed some fake movies
10.times do
  Movie.find_or_create_by(title: Faker::Movie.title) do |movie|
    movie.overview = Faker::Movie.quote
    movie.poster_url = Faker::Avatar.image
    movie.rating = Faker::Number.between(from: 1, to: 10)
  end
end



#Movie.create([
 # { title: "Wonder Woman 1984", overview: "Wonder Woman comes into conflict with the Soviet Union during the Cold War in the 1980s", poster_url: "https://image.tmdb.org/t/p/original/8UlWHLMpgZm9bx6QYh0NFoq67TZ.jpg", rating: 6.9 },
 # { title: "The Shawshank Redemption", overview: "Framed in the 1940s for double murder, upstanding banker Andy Dufresne begins a new life at the Shawshank prison", poster_url: "https://image.tmdb.org/t/p/original/q6y0Go1tsGEsmtFryDOJo3dEmqu.jpg", rating: 8.7 },
 # { title: "Titanic", overview: "101-year-old Rose DeWitt Bukater tells the story of her life aboard the Titanic.", poster_url: "https://image.tmdb.org/t/p/original/9xjZS2rlVxm8SFx8kPC3aIGCOYQ.jpg", rating: 7.9 },
 # { title: "Ocean's Eight", overview: "Debbie Ocean, a criminal mastermind, gathers a crew of female thieves to pull off the heist of the century.", poster_url: "https://image.tmdb.org/t/p/original/MvYpKlpFukTivnlBhizGbkAe3v.jpg", rating: 7.0 }
 # Add more movie records as needed
#])
