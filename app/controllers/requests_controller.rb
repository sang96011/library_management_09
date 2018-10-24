class RequestsController < ApplicationController
  before_action :authenticate_user!
  before_action :load_request, only: [:destroy, :accept_request, :reject_request]
  before_action :admin?, only: :destroy
  load_and_authorize_resource

  def show
    @request_details = RequestDetail.of_request(params[:id])
    if @request_details.blank?
      flash[:info] = t ".no_detail"
      redirect_to root_path
    end
  end

  def update
    if current_request.update_attributes request_params
      UserMailer.create_request(@request.user_id).deliver_later
      flash[:info] = t ".created"
      session[:request_id] = nil
    else
      flash[:danger] = t ".create_fail"
    end
    redirect_to requests_path
  end

  def index
    if current_user.admin?
      @requests = Request.newest
    else
      @requests = Request.of_user(current_user.id).newest
    end

    if @requests.blank?
      flash[:info] = t ".no_request"
      redirect_to root_path
    end
  end

  def destroy
    if @request.destroy
      UserMailer.delete_request(@request.user_id).deliver_later
      flash[:info] = t ".deleted"
    else
      flash[:danger] = t ".delete_fail"
    end
    redirect_to requests_path
  end

  def accept_request
    if @request.accept!
      UserMailer.accept_request(@request.user_id).deliver_later
      flash[:success] = t ".accept_success"
    else
      flash[:danger] = t ".accept_fail!"
    end
    redirect_to requests_path
  end

  def reject_request
    if @request.reject!
      UserMailer.reject_request(@request.user_id).deliver_later
      flash[:success] = t ".reject_success"
    else
      flash[:danger] = t ".reject_fail!"
    end
    redirect_to requests_path
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
