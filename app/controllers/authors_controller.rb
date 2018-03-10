class AuthorsController < ApplicationController

  before_action :find_author

  def show

  end

  private

  def find_author
    @author = Author.find_by(id: params[:id])
    @authors = find_books(@author)
    if !@author
      redirect_to authenticated_root_path
    end
  end

  def find_books(author)
    Book.find_books_by_author(author, current_user)
  end
  
end
