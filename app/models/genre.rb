class Genre < ActiveRecord::Base
  
  has_many :book_genres
  has_many :books, through: :book_genres
  has_many :authors, through: :books

  validates_uniqueness_of :name

  def find_genres_books(current_user) 
    self.books.where(user_id: current_user.id)
  end

end
