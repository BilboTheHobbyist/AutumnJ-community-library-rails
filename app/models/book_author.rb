class BookAuthor < ActiveRecord::Base

  belongs_to :book
  belongs_to :author 

  validates :author_id, uniqueness: {scope: :book_id}

end
