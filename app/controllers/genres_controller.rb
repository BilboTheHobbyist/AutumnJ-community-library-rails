class GenresController < ApplicationController

  before_action :find_genre

  def show

  end

  private

  def find_genre
    @genre = Genre.find_by(id: params[:id])
    @books = find_books(@genre)
    if !@genre
      redirect_to authenticated_root_path
    end
  end

  def find_books(genre)
    Book.find_books_by_genre(genre, current_user)
  end

end
