class BooksController < ApplicationController

  before_action :find_book
  skip_before_action :find_book, :only => [:new, :create, :show_borrowed, :return_book, :show_available_to_borrow, :borrow_book]

  def show
    if @book.borrowed_by?
      @text = "Borrowed by #{@book.borrowed_by?}"
    elsif @book.available?(current_user)
      @text = "Available for the community to borrow"
    else
      @text = "Private - not available for the community to borrow"
    end
  end

  def show_borrowed
    @book = Book.find_by(id: params[:id], borrower: current_user.id)
    if @book.nil?
      redirect_to authenticated_root_path
    end
  end

  def show_available_to_borrow
    @book = Book.find(params[:id])
    if !@book.available?(current_user)
      redirect_to authenticated_root_path
    end
  end

  def new
    @book = Book.new
  end

  def create #does not show error upon create when author name is added multiple times
  #without title it does not persist to db and other tests against book joins table cannot run
    @book = Book.new(book_params)
    @book.user = current_user
    if @book.save
      redirect_to book_path(@book)
    else 
      render :new
    end
  end

  def edit
    if @book.borrowed_by? 
      @text = "Borrowed by #{@book.borrowed_by?}"
    end
  end

  def update
    @book.update(book_params)

    if @book.save
      redirect_to book_path(@book)
    else
      render :edit
    end
  end

  def borrow_book
    @book = Book.find(params[:id])
    if !@book.available?(current_user)
      redirect_to authenticated_root_path
    else
      @book.borrow(current_user)
      redirect_to authenticated_root_path
    end
  end

  def return_book
    @book = Book.find_by(id: params[:id], borrower: current_user.id)
    if @book.nil?
      redirect_to authenticated_root_path
    else
      @book.return
      redirect_to authenticated_root_path
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
