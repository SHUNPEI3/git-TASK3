class BooksController < ApplicationController

  def create
    @book = Book.new(book_params)
    @book.user_id = current_user.id
    if @book.save
      flash[:notice]="You have created book successfully."
      redirect_to book_path(@book.id)
    else
    @books = Book.all
    render :index
    end
  end

  def index
    @book = Book.new
    @books = Book.all
  end

  def show
    @book = Book.find(params[:id])
    sidebar_type1
  end

  def edit
    is_matching_login_user
    @book = Book.find(params[:id])
  end
  def update
    @book = Book.find(params[:id])
    if @book.update(book_params)
      flash[:notice]="You have updated book successfully."
      redirect_to book_path(@book.id)
    else
      render :edit
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end
# #############################################################################
# #############################################################################
private

  def sidebar_type1
    @tentative = Book.find(params[:id])
    @userinfo = @tentative.user
    @newbook = Book.new
  end

  def book_params
    params.require(:book).permit(:title,:body)
  end

  def is_matching_login_user
    book = Book.find(params[:id])
    user_id = book.user.id
    login_user_id = current_user.id
    if(user_id != login_user_id)
      redirect_to books_path
    end
  end

end
