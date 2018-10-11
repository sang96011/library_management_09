class CategoriesController < ApplicationController
  before_action :load_category, except: [:index, :new, :create]
  def index
    @categories = Category.search(params[:query])
  end

  def new
    @category = Category.new
  end

  def create
    @category = Category.new category_params
    if @category.save
      flash[:success] = t ".created"
      redirect_to categories_path
    else
      flash[:danger] = t ".create_fail"
      render :new
    end
  end

  def show; end

  def edit; end

  def update
    if @category.update_attributes category_params
      flash[:success] = t ".updated"
    else
      flash[:danger] = t ".update_fail"
    end
    redirect_to categories_path
  end

  def destroy
    if @category.destroy
      flash[:success] = t ".deleted"
    else
      flash[:danger] = t ".delete_fail"
    end
    redirect_to categories_path
  end

  private

  def category_params
    params.require(:category).permit :name, :parent_id, :query
  end

  def load_category
    @category = Category.find_by id: params[:id]
    return if @category
    flash[:danger] = ".no_category"
    redirect_to categories_path
  end
end
