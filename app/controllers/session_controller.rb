class SessionController < ApplicationController
  def new; end

  def create
    user = User.find_by email: params[:session][:email].downcase
    if user && user.authenticate(params[:session][:password])
      log_in user
      flash[:info] = t("session.controller.congrate")
      redirect_to root_path
    else
      flash.now[:danger] = t("session.controller.invalid")
      render :new
    end
  end

  def destroy
    log_out if logged_in?
    redirect_to root_path
  end
end
