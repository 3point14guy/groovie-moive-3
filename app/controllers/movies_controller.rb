class MoviesController < ApplicationController
  before_action :set_movie, only: [:show, :edit, :update, :destroy]

  # GET /movies
  # GET /movies.json
  def index
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

  # GET /movies/1
  # GET /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        if user_signed_in?
          format.html { redirect_to logged_in_path, notice: 'Movie was successfully created.' }
        end
        format.html { redirect_to movies_path, notice: 'Movie was successfully created.' }
        format.json { render :show, status: :created, location: @movie }
      else
        format.html { render :new }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { render :show, status: :ok, location: @movie }
      else
        format.html { render :edit }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:title, :year, :genre, :plot, :poster, :rotten, :imdb, :website)
    end
end
