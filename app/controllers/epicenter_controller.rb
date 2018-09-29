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
  	@friends = []

  	User.all.each do |friend|
  		if current_user.following.include?(friend.id)
  			@friends.push(friend)
  		end
  	end
  end

  def add_friend
	  current_user.following.push(params[:id].to_i)
  	current_user.save

  	# redirect_to show_user_path(id: params[:id])  	
  	redirect_to all_users_path  	
  end

  def remove_friend
  	current_user.following.delete(params[:id].to_i)
  	current_user.save
  	 # redirect_to show_user_path(id: params[:id])  	
  	redirect_to all_users_path
  end
end
