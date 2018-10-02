class FollowsController < ApplicationController

  before_action :load_book

  def index
    @follows = Follow.all
  end

  def new
    @follow = Follow.new
  end

  def create
    @follow = current_user.follows.build target: @book
    if @follow.save
      load_respond "success", t("follow.success")
    else
      load_respond "danger", t("follow.fail")
    end
  end

  def destroy
    follow = Follow.find_by(target_id: params[:id], user_id: current_user)
    if follow && follow.destroy
      load_respond "success", t("unfollow.success")
    else
      load_respond "danger", t("unfollow.fail")
    end
  end

  def show
    @follow = Follow.find_by id: params[:id]
    return if @follow
    flash[:danger] = t ".show_follow"
  end

  private

  def load_book
    @book = Book.find_by id: params[:book_id]
    return if @book
    flash[:info] = t "books.no_book"
    redirect_to books_path
  end

  def load_respond type, message
    respond_to do |format|
      flash[type] = message
      format.html{redirect_to @book.target}
      format.js
    end
  end
end
