class BooksController < ApplicationController

  before_action :authenticate_user!
  before_action :ensure_correct_user, only: [:edit, :update, :destroy]

  def show
    @book = Book.find(params[:id])
    @book_comment = BookComment.new
    @book_view = @book
    unless ViewCount.find_by(user_id: current_user.id, book_id: @book_view.id)
      current_user.view_counts.create(book_id: @book_view.id)
    end
  end

  def index
    # @books = Book.all
    # これでも行けた↓
    @books = Book.includes(:favorites).sort {|a,b| b.favorites.size <=> a.favorites.size}
    # @books = Book.last_week
    # to = Time.current.at_beginning_of_day
    # from = (to - 6.day).at_end_of_day
    # @books = Book.all.sort {|a,b|
    #   b.favorites.where(created_at: from...to).size <=>
    #   a.favorites.where(created_at: from...to).size
    # }
    @book = Book.new
    Book.all.each do |book|
      unless ViewCount.find_by(user_id: current_user.id, book_id: book.id)
        current_user.view_counts.create(book_id: book.id)
      end
    end
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to book_path(@book), notice: "You have created book successfully."
    else
      @books = Book.all
      render 'index'
    end
  end

  def edit
    # @book = Book.find(params[:id])
  end

  def update
    # @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to book_path(@book), notice: "You have updated book successfully."
    else
      render "edit"
    end
  end

  def destroy
    # @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  private

  def book_params
    params.require(:book).permit(:title, :body)
  end

  def ensure_correct_user
    @book = Book.find(params[:id])
    unless @book.user == current_user
      redirect_to books_path
    end
  end
end
