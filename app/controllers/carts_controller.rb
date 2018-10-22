class CartsController < ApplicationController
  skip_load_and_authorize_resource
  def show
    @request_details = current_request.request_details
  end
end
