class Book < ActiveRecord::Base

  validates :title, presence: true 
  #title is also required field when entering book

  belongs_to :user
  has_many :book_authors
  has_many :authors, through: :book_authors
  has_many :book_genres
  has_many :genres, through: :book_genres
  has_many :comments

  accepts_nested_attributes_for :authors, reject_if: proc { |attributes| attributes['name'].blank? }
  accepts_nested_attributes_for :genres, reject_if: proc { |attributes| attributes['name'].blank? }

  def self.borrowable(current_user)
    where("user_id != ? AND status = ?", current_user.id, "available").order(:title)
  end

  def self.returnable(current_user)
    where({borrower: current_user.id, status: "borrowed"}).order(:title)
  end

  def borrowed_by?
    self.status == "borrowed" ? User.find(self.borrower).name : false
  end

  def available?(current_user)
    self.status == "available" && self.user_id != current_user.id && self.borrower.nil?
  end

  def return
    self.status = "available"
    self.borrower = nil
    self.save 
  end

  def borrow(current_user)
    self.status = "borrowed"
    self.borrower = current_user.id
    self.save 
  end

end
