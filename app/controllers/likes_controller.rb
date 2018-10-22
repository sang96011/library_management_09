class LikesController < ApplicationController
  before_action :load_book, only: [:create, :destroy]
  before_action :load_like, only: :destroy
  load_and_authorize_resource

  def index
    @likes = Like.all
  end

  def new
    @like = Like.new
  end

  def create
    if current_user.like? @book
      flash[:notice] = t ".was_liked_book"
    elsif current_user.likes.build(target: @book).save
      flash[:notice] = t ".liked_book"
    else
      flash[:notice] = t ".like_fail_book"
    end
  end

  def destroy

    if @like&.destroy
      flash[:notice] = t ".unliked_book"
    else
      flash[:notice] = t ".unlike_fail"
    end
  end

  def show
    @like = Like.find_by id: params[:id]
    return if @like
    flash[:danger] = t ".show_like"
  end

  private

  def load_like
    @like = Like.find_by(target_id: @book.id, target_type:@book.class.name, user_id: current_user.id)
    return if @like
    redirect_to @book
  end

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash[:info] = t "books.no_book"
    redirect_to books_path
  end
end
