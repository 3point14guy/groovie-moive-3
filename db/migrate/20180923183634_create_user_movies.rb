class CreateUserMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :user_movies do |t|
      t.integer :user_id
      t.integer :movie_id
      t.string :user_rating
      t.string :user_comment

      t.timestamps
    end
  end
end
