class AuthorsController < ApplicationController
  before_action :load_author, except: [:new, :create, :index]

  def index
     @authors = Author.paginate(page: params[:page],
      per_page: Settings.author.index.per_page)
  end

  def show; end

  def new
    @author = Author.new
  end

  def create
    @author = Author.new author_params
    if @author.save
      flash[:info] = t "author.controller.create"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @author.update_attributes(author_params)
      flash[:success] = t "author.controller.update.success"
      redirect_to authors_path
    else
      render :edit
    end
  end

  def destroy
    if @author.destroy
      flash[:success] = t "author.controller.destroy.success"
      redirect_to authors_path
    else
      flash[:danger] = t "author.controller.destroy.danger"
      redirect_to root_path
    end
  end

  private

  def author_params
    params.require(:author).permit :name, :content
  end

  def load_author
    @author = Author.find_by id: params[:id]
    return if @author
    flash[:info] = t "author.controller.load.no_author"
    redirect_to signup_path
  end
end
