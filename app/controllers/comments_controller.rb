class CommentsController < ApplicationController
   before_action :load_book, except: [:index, :create, :new]

  def index
    @comments = Comment.all
  end

  def new
    @comment = Comment.new
  end

  def create
    @comment = Comment.new comment_params
    @comment.user = current_user
    if @comment.save
      respond_to do |format|
        flash[:success] = t "comment.commented"
          format.html {redirect_to @comment.target}
          format.js
        end
    else
      respond_to do |format|
        flash[:danger] = t "comment.failed"
          format.html {redirect_to @comment.target}
          format.js
      end
    end
  end

  def show
    @comment = Comment.find_by id: params[:id]
  end

  def destroy; end

  private

  def comment_params
    params.require(:comment).permit :body, :target_id, :target_type
  end

  def load_book
    @book = Book.find_by id: params[:id]
    return if @book
      flash[:info] = t "book.no_book"
      redirect_to books_path
  end
end
