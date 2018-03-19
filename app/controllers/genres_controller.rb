class GenresController < ApplicationController

  before_action :find_genre

  def show

  end

  private

    def find_genre
    @genre = Genre.find_by(id: params[:id])
    @books = @genre.find_genres_books(current_user)
    if !@genre
      redirect_to authenticated_root_path
    end
  end

end
