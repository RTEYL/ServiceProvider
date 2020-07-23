class ServiceRequestsController < ApplicationController
  before_action :redirect_if_not_logged_in

  def create
    @service_request = ServiceRequest.new(service_request_params)
    if @service_request.save
      redirect_to user_service_requests_path(current_user)
    else
      redirect_back fallback_location: root_path
    end
  end

  private

  def service_request_params
    params.require(:service_request).permit(:provider_id, :user_id)
  end
end
