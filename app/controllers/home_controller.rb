class HomeController < ApplicationController
  def index
    @user_books = current_user.all_books
    @books_to_borrow = Book.borrowable(current_user)
    @books_to_return = Book.returnable(current_user)
  end
end
