class RequestDetailsController < ApplicationController
  before_action :load_request, only: [:create, :update, :destroy]
  before_action :load_detail, only: [:update, :destroy]
  load_and_authorize_resource

  def create
    @request_detail = @request.request_details.find_by book_id:
      request_detail_params[:book_id]
    if @request_detail
      flash[:info] = t ".exist_detail"
    else
      @request_detail = @request.request_details.build request_detail_params
    end
    @request.save
    session[:request_id] = @request.id
    redirect_to root_path
  end

  def update
    @request_detail.update_attributes request_detail_params
    if @request_detail.update_attributes request_detail_params
      flash[:info] = t ".updated"
      redirect_back fallback_location: root_path
    else
      flash[:danger] = t ".update_fail"
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    if @request_detail.destroy
      flash[:info] = t ".deleted"
      redirect_back fallback_location: root_path
    else
      flash[:danger] = t ".delete_fail"
      redirect_back fallback_location: root_path
    end
  end

  private

  def request_detail_params
    params.require(:request_detail).permit :number, :book_id
  end

  def load_request
    @request = current_request
  end

  def load_detail
    @request_detail = @request.request_details.find_by id: params[:id]
    if @request_detail.blank?
      flash[:danger] = t ".no_detail"
      redirect_to root_path
    end
  end
end
