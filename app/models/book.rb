class Book < ActiveRecord::Base

  validates :title, presence: true, uniqueness: {scope: :user_id, message: "in use by another book in your collection"}

  belongs_to :user
  has_many :book_authors
  has_many :authors, through: :book_authors
  has_many :book_genres
  has_many :genres, through: :book_genres
  has_many :comments

  # accepts_nested_attributes_for :authors, reject_if: proc { |attributes| attributes['name'].blank? }
  # accepts_nested_attributes_for :genres, reject_if: proc { |attributes| attributes['name'].blank? }

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
    self.update(status: "available", borrower: nil)
    self.save
  end

  def borrow(current_user)
    self.update(status: "borrowed", borrower: current_user.id)
    self.save
  end

  def authors_attributes=(author_attributes)
    author_attributes.values.each do |author_details|
      if author_details[:name].strip != ""
        author = Author.find_or_create_by(name: author_details[:name].titleize)
        self.book_authors.build(author: author)
      end
    end
  end

  def genres_attributes=(genre_attributes)
    genre_attributes.values.each do |genre_details|
      if genre_details[:name].strip != ""
        genre = Genre.find_or_create_by(name: genre_details[:name].titleize)
        self.book_genres.build(genre: genre)
      end
    end
  end

end
