class ReturnController < ApplicationController

  before_action :find_book

#update these routes throughout:
  # get '/books/:id/borrowed', to: 'books#show_borrowed', as:'borrowed_book'
  # post '/books/:id/return', to: 'books#return_book', as: 'return_book'

  def show_borrowed
    if @book
      @comments = Comment.user_comments_by_book(@book.id, current_user)
    else
      redirect_to authenticated_root_path
    end
  end

  def return_book
    if @book.nil?
      redirect_to authenticated_root_path
    else
      @book.return
      redirect_to authenticated_root_path
    end
  end

  private

  def find_book
    @book = Book.find_by(id: params[:id], borrower: current_user.id)
  end

end