class BooksController < ApplicationController

  before_action :find_book
  skip_before_action :find_book, :only => [:new, :create]

  def show
    if @book.borrowed?
      @text = "Borrowed by #{@book.borrowed?}"
    elsif @book.available?
      @text = "Available for the community to borrow"
    else
      @text = "Private - not available for the community to borrow"
    end
  end

  def new
    @book = Book.new
  end

  def create
    if current_user.books.all.find_by(title: params[:book][:title])
      redirect_to authenticated_root_path, {notice: 'That book is already in your collection.'}
    else 
      @book = Book.new(book_params)
      @book.user = current_user
      if @book.save
        redirect_to book_path(@book)
      else 
        redirect_to new_book_path, {notice: 'There was an error saving the book. Please enter the info again.'}
      end
    end
  end

  def destroy
    @book.delete
    redirect_to authenticated_root_path, {notice: 'The book was removed from your collection.'}
  end

  private

    def find_book
      @book = Book.find_by(id: params[:id], user_id: current_user.id)
      if @book.nil?
        redirect_to authenticated_root_path, {notice: 'Please select one of your books below'}
      end
    end

    def book_params
      params.require(:book).permit(
        :title, 
        :year_published, 
        :language, 
        :status, 
        :description, 
        :author_ids => [], 
        authors_attributes: [:name],
        :genre_ids => [], 
        genres_attributes: [:name],
        )
    end

end