class CreateMovies < ActiveRecord::Migration[5.1]
  def change
    create_table :movies do |t|
      t.string :title
      t.integer :year
      t.string :genre
      t.string :plot
      t.string :poster
      t.integer :rotten
      t.decimal :imdb
      t.string :website

      t.timestamps
    end
  end
end
