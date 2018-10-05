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
      flash[:notice] = t ".followed"
    else
      flash[:notice] = t ".follow_fail"
    end
  end

  def destroy
    follow = Follow.find_by(target_id: params[:id], user_id: current_user)
    if follow && follow.destroy
      flash[:notice] = t ".unfollowed"
    else
      flash[:notice] = t ".unfollow_fail"
    end
  end

  def show
    @follow = Follow.find_by id: params[:id]
    return if @follow
    flash[:danger] = t ".show_follow"
  end

  private

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book
    flash[:info] = t "books.no_book"
    redirect_to books_path
  end
end
