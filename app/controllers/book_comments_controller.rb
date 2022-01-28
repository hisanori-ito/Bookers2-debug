class BookCommentsController < ApplicationController
  def create
    book = Book.find(params[:book_id])
    comment = current_user.book_comments.new(book_comments_params)
    comment.book_id = book.id
    comment.save
    redirect_to book_path(book)
  end

  def destroy
    Book_comment.find(params[:id]).destroy
    redirect_to book_path(:book_id)
  end

  private

  def book_comments_params
    params.require(:book_comment).permit(:comment)
  end
end
