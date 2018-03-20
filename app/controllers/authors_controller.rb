class AuthorsController < ApplicationController

  before_action :find_author

  def show    

  end

  private

  def find_author
    @author = Author.find_by(id: params[:id])
    @books = @author.find_authors_books(current_user)
    if !@author
      redirect_to authenticated_root_path
    end
  end
  
end
