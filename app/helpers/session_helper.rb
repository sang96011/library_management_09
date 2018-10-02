module SessionHelper
  def log_in user
    session[:user_id] = user.id
  end

  def current_user
    user_id = session[:user_id]
    if user_id
      @current_user ||= User.find_by(id: user_id)
    end
  end

  def logged_in?
    current_user.present?
  end

  def log_out
    session.delete(:user_id)
    @current_user = nil
  end

  def admin?
    unless logged_in? && @current_user.admin
      flash[:danger] = t "cant_permit"
      redirect_to root_path
    end
  end
end
