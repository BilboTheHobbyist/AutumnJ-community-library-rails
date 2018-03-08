class Book < ActiveRecord::Base

  validates :title, presence: true 
  #title is also required field when entering book

  belongs_to :user
  has_many :book_authors
  has_many :authors, through: :book_authors
  has_many :book_genres
  has_many :genres, through: :book_genres
  has_many :comments

  def self.borrowable(current_user)
    # where.not(id: current_user.id).where(status: "available")
    where({id: !current_user.id, status: "available"})
  end

  def self.returnable(current_user)
    where({borrower: current_user.id, status: "borrowed"})
  end

  def borrowed?
    self.status == "borrowed" ? User.find(self.borrower).name : false
  end

  def available?
    self.status == "available"
  end

end
