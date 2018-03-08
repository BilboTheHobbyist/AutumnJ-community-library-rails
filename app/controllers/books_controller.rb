class BooksController < ApplicationController

  def show
    @book = Book.find(params[:id])
    if @book.borrowed?
      @text = "Borrowed by #{@book.borrowed?}"
    elsif @book.available?
      @text = "Available for the community to borrow"
    else
      @text = "Private - not available for the community to borrow"
    end
  end

end
