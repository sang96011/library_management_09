class CartsController < ApplicationController
  def show
    @request_details = current_request.request_details
  end
end
