class BooksController < ApplicationController
    before_action :ensure_current_user,{only: [:edit,:update]}
  def ensure_current_user
    @book=Book.find(params[:id])
    if current_user.id != @book.user_id
      redirect_to books_path,notice: '権限がありません'
    end
  end

  def index
    @book = Book.new
    @books = Book.all
  end

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      redirect_to @book, notice: 'You have created book successfully.'
    else
      @books = Book.all
      render :index
    end
  end

  def show
    @book=Book.new
    @books=Book.find(params[:id])
    @user=User.find_by(id:@books.user_id)
  end

  def edit
    @book = Book.find(params[:id])

  end

  def destroy
    @book = Book.find(params[:id])
    @book.destroy
    redirect_to books_path
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      redirect_to @book,notice: 'You have updated book successfully.'
    else
      render :edit
    end
  end


  private

  def book_params
    params.require(:book).permit(:title,:body)
  end
end
