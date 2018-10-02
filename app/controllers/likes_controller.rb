class LikesController < ApplicationController
  before_action :load_book
  def index
    @likes = Like.all
  end

  def new
    @like = Like.new
  end

  def create
    @like = current_user.likes.build target: @book
    if @like.save
      respond_to do |format|
        flash[:success] = t "like.success"
        format.html{redirect_to @book.target}
        format.js
      end
    else
      respond_to do |format|
        flash[:danger] = t "like.fail"
        format.html{redirect_to @book.target}
        format.js
      end
    end
  end

  def destroy
    like = Like.find_by(target: @book, user_id: current_user.id)
    if like
      like.destroy
      respond_to do |format|
        flash[:success] = t "unlike.success"
        format.html{redirect_to @book.target}
        format.js
      end
    else
      respond_to do |format|
        flash[:danger] = t "unlike.fail"
        format.html{redirect_to @book.target}
        format.js
      end
    end
  end

  def show
    @like = Like.find_by id: params[:id]
    return if @like
    flash[:danger] = t ".show_like"
  end

  private

  def load_book
    @book = Book.find_by id: params[:book_id]
    return if @book
    flash[:info] = t "books.no_book"
    redirect_to books_path
  end
end
