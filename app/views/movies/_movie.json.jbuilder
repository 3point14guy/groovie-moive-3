json.extract! movie, :id, :title, :year, :genre, :plot, :poster, :rotten, :imdb, :website, :created_at, :updated_at
json.url movie_url(movie, format: :json)
