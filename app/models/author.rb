class Author < ActiveRecord::Base

  has_many :book_authors
  has_many :books, through: :book_authors
  has_many :genres, through: :books

  validates_uniqueness_of :name

  def find_authors_books(current_user) 
    self.books.where(user_id: current_user.id).order(:title)
  end

  def find_authors_borrowable_books(current_user)
    self.books.where("user_id != ? AND status = ?", current_user.id, "available").order(:title)
  end

end
