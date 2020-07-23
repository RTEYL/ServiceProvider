class ServiceRequestsController < ApplicationController
  before_action :redirect_if_not_logged_in

  def index
    @provider = Provider.find_by_id(current_user)
  end

  def create
    @service_request = ServiceRequest.new(service_request_params)
    if @service_request.save
      redirect_to user_path(current_user)
    else
      redirect_back fallback_location: root_path
    end
  end

  def update
    binding.pry
  end

  private

  def service_request_params
    params.require(:service_request).permit(:service_id, :provider_id, :user_id)
  end
end
