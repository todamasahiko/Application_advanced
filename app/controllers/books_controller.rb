class BooksController < ApplicationController
  
  before_action :authenticate_user!, except:[:top, :home, :about]

  def top
  end

  def about
  end

  def index
    @books = Book.all
    @book = Book.new
  end

  def show
    @book = Book.find(params[:id])
    @book_new = Book.new
    @user = @book.user
  end

  def edit
  	@book = Book.find(params[:id])
  	if @book.user_id == current_user.id
  	  render :edit
  	else
  	  redirect_to books_path
  	end
  end

  def create
    @books = Book.all
    @book = Book.new(book_params)
    @book.user_id = current_user.id
      if @book.save
        flash[:notice] = "You have created book successfully."
        redirect_to book_path(@book.id)
      else
        render :index
      end
  end

  def update
    @book = Book.find(params[:id])
    @book.user_id = current_user.id
      if @book.update(book_params)
        flash[:notice] = "You have updated book successfully."
        redirect_to book_path(@book.id)
      else
      	render :index
      end
  end

  def destroy
  	@book = Book.find(params[:id])
  	@book.destroy
  	redirect_to books_path
  end

  private
  def book_params
  	params.require(:book).permit(:title, :body, :user_id)
  end

end