class BookAuthor < ActiveRecord::Base

  belongs_to :book
  belongs_to :author 

  validates :author_id, uniqueness: {scope: :book_id, message: "author is already associataed with"}
  validates :author, presence: true, if: -> { author_id.present? }

end
