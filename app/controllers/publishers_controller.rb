class PublishersController < ApplicationController
  before_action :load_publisher, except: [:index, :new, :create]
  before_action :admin?

  def index
    @publishers = Publisher.search(params[:query]).newest._page params[:page]
    respond_to do |format|
      format.html
      format.xls{send_data @publishers.to_xls}
    end
  end

  def edit; end

  def update
    if @publisher.update_attributes(publisher_params)
      flash[:info] = t "flash.update_success"
      redirect_to publishers_path
    else
      render :edit
    end
  end

  def new
    @publisher = Publisher.new
  end

  def create
    @publisher = Publisher.new publisher_params
    if @publisher.save
      flash[:info] = t "flash.create_success"
      redirect_to publishers_path
    else
      render :new
    end
  end

  def destroy
    if @publisher.destroy
      flash[:info] = t "flash.delete_success"
      redirect_to publishers_path
    else
      flash.now[:danger] = t "flash.delete_fail"
      render :new
    end
  end

  private

  def publisher_params
    params.require(:publisher).permit :name, :address, :query
  end

  def load_publisher
    @publisher = Publisher.find_by id: params[:id]
    return if @publisher
    flash[:danger] = t "flash.cant_find"
    redirect_to root_path
  end
end
