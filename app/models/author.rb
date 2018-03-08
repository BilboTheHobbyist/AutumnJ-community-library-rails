class Author < ActiveRecord::Base

  has_many :book_authors
  has_many :books, through: :book_authors
  has_many :genres, through: :books

  validates_uniqueness_of :name


end
