class BooksController < ApplicationController
  before_action :find_book, except: [:new, :create, :index]
  before_action :load_all, only: [:new, :edit]

  def index
    @books = Book.search(params[:search])._page params[:page]
    @request_detail = current_request.request_details.new
  end

  def show
    @comment = Comment.where(target: @book)
    @new_comment = Comment.new
    @like = Like.where(target: @book)
    @follow = Follow.where(target: @book)
  end

  def new
    @book = Book.new
    @new_comment = Comment.new
    @like = Like.new
    @follow = Follow.new
  end

  def create
    @book = Book.new book_params
    if @book.save
      flash[:success] = t "books.created"
      redirect_to books_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @book.update_attributes(book_params)
      flash[:success] = t "books.updated"
      redirect_to books_path
    else
      render :edit
    end
  end

  def destroy
    if @book.destroy
      flash[:success] = t "books.destroy.success"
      redirect_to books_path
    else
      flash[:danger] = t "books.destroy.danger"
      redirect_to root_path
    end
  end

  private

  def book_params
    params.require(:book).permit :content, :name, :author_id, :publisher_id,
      :number_page, :year, :status, :category_id, :search
  end

  def find_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash[:info] = t "books.no_book"
    redirect_to books_path
  end

  def load_all
    @category = Category.all.alpha
    @author = Author.all
    @publisher = Publisher.all
  end
end
