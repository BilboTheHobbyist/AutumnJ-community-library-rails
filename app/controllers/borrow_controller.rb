class BorrowController < ApplicationController 

  before_action :find_book

  #update routes throughout
  # get '/books/:id/borrow', to: 'books#show_available_to_borrow', as:'view_borrowable_book'
  # post '/books/:id/borrow', to: 'books#borrow_book', as:'borrow_book'

  def show
    @comments = Comment.all_comments(@book.id)
    if !@book.available?(current_user)
      redirect_to authenticated_root_path
    end
  end

  def update
    if !@book.available?(current_user)
      redirect_to authenticated_root_path
    else
      @book.borrow(current_user)
      redirect_to authenticated_root_path
    end
  end

  private

  def find_book
    @book = Book.find(params[:id])
  end

end