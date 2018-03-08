class BookGenre < ActiveRecord::Base

  belongs_to :book
  belongs_to :genre

  validates :genre_id, uniqueness: {scope: :book_id}
  
end
