module RequestsHelper
  def current_request
    request = Request.find_by id: session[:request_id]
    if session[:request_id].present? && request.present?
      request
    elsif user_signed_in?
      current_user.requests.new
    else
      Request.new
    end
  end
end
