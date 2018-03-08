class CreateBookGenres < ActiveRecord::Migration
  def change
    create_table :book_genres do |t|
      t.integer :book_id
      t.integer :genre_id

      t.timestamps null: false
    end
  end
end
