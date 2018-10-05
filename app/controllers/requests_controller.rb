class RequestsController < ApplicationController
  before_action :admin?, only: :destroy
  before_action :load_request, only: [:destroy, :accept_request]

  def show
    @request_details = RequestDetail.where request_id: params[:id]
    if @request_details.blank?
      flash[:info] = t ".no_detail"
      redirect_to root_path
    end
  end

  def update
    if current_request.update_attributes request_params
      flash[:info] = t ".created"
      session[:request_id] = nil
    else
      flash[:danger] = t ".create_fail"
    end
    redirect_to root_path
  end

  def index
    @requests = Request.where user_id: current_user.id
    if @requests.blank?
      flash[:info] = t ".no_request"
      redirect_back fallback_location: root_path
    end
  end

  def destroy
    if @request.destroy
      flash[:info] = t ".deleted"
    else
      flash[:danger] = t ".delete_fail"
    end
    redirect_to requests_path
  end

  def accept_request
    if @request.accept!
      flash[:success] = t ".accept_success"
    else
      flash[:danger] = t ".accept_fail!"
    end
    redirect_back fallback_location: root_path
  end

  private

  def load_request
    @request = Request.find_by id: params[:id]
    flash[:danger] = t ".cant_find" if @request.blank?
  end

  def request_params
    params.require(:request).permit :from_day, :to_day
  end
end
