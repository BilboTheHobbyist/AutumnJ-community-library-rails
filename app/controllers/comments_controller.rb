class CommentsController < ApplicationController

  before_action :find_book

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new(comment_params)
    @comment.created_at = Time.now
    @comment.user_id = current_user.id #should this be hidden field in form?
    if @comment.save 
      redirect_to borrowed_book_path(@book) 
    else
      render :new
    end
  end 

  private

  def find_book
     @book = Book.find_by(id: params[:book_id], borrower: current_user.id)
  end

  def comment_params
    params.require(:comment).permit(
      :book_id, 
      # :user_id, 
      :content
      )
  end

end
