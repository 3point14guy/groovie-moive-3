class EpicenterController < ApplicationController
  def logged_in
    @movies = Movie.all
    @movie = Movie.new

    if params[:title] != "" && !params[:title].nil? 
      response = HTTParty.get("http://www.omdbapi.com/?t=#{params[:title]}&apikey=#{ENV['omdb_api_key']}&")
      @title = response["Title"]
      @year = response["Year"]
      @genre = response["Genre"]
      @plot = response["Plot"]
      @rotten_value = response["Ratings"][1]["Value"]
      @imdb_value = response["imdbRating"]
      @poster = response["Poster"]
      @website = response["Website"]
    end  	
  end

  def all_users
  	@users = User.all
  end

  def friends
  end
end
