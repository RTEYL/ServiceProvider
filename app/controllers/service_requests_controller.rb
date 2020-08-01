class ServiceRequestsController < ApplicationController
  before_action :redirect_if_not_logged_in

  def index
    @user = User.find_by_id(current_user.id)
    @service_requests = @user.service.service_requests
  end

  def create
    @service_request = current_user.service_requests.build(service_request_params)
    if @service_request.save
      redirect_to user_path(current_user)
      flash[:notice] = "Request has been sent"
    else
      redirect_back fallback_location: root_path
      flash[:notice] = "Request failed"
    end
  end

  def update
    @service_request = ServiceRequest.find_by_id(params[:id])
    if @service_request
      @service_request.update(service_request_params)
    else
      redirect_back fallback_location: root_path
      flash[:notice] = "Request Completed"
    end
    custom_error_messages("alert", @service_request)
    redirect_to user_service_requests_path(current_user)
  end

  private

  def service_request_params
    params.require(:service_request).permit(:completed, :service_id, :user_id)
  end
end
