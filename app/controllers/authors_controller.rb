class AuthorsController < ApplicationController
  before_action :authenticate_user!, except: :index
  before_action :load_author, except: [:new, :create, :index]

  def index
    @authors = Author.search(params[:search])._page params[:page]
    respond_to do |format|
      format.html
      format.xls{send_data @authors.to_xls}
    end
  end

  def show
    @follow = Follow.of_author(@author)
  end

  def new
    @author = Author.new
    @follow = Follow.new
  end

  def create
    @author = Author.new author_params
    if @author.save
      flash[:info] = t ".created"
      redirect_to root_path
    else
      render :new
    end
  end

  def edit; end

  def update
    if @author.update_attributes(author_params)
      flash[:success] = t ".updated"
      redirect_to authors_path
    else
      render :edit
    end
  end

  def destroy
    begin
      if @author.destroy
        flash[:success] = t ".destroy_success"
        redirect_to authors_path
      else
        flash[:danger] = t ".destroy_danger"
        redirect_to root_path
      end
    rescue Exception => e
      flash[:danger] = t ".destroy_danger"
      redirect_to root_path
    end
  end

  private

  def author_params
    params.require(:author).permit :name, :content, :search
  end

  def load_author
    @author = Author.find_by id: params[:id]
    return if @author
    flash[:info] = t ".no_author"
    redirect_to root_path
  end
end
