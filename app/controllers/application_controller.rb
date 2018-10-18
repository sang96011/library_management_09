class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  include RequestsHelper

  before_action :configure_permitted_parameters, if: :devise_controller?

  def configure_permitted_parameters
    added_attrs = [:name]
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end

  def admin?
    unless user_signed_in? && current_user.admin
      flash[:danger] = t "cant_permit"
      redirect_to root_path
    end
  end
end
