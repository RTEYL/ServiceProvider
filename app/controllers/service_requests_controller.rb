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
    @service_request = ServiceRequest.find_by_id(params[:id])
    if @service_request
      @service_request.update(service_request_params)
      destroy if @service_request.completed
    else
      redirect_back fallback_location: root_path
    end
    redirect_to provider_service_requests_path(current_user)
  end

  def destroy
    ServiceRequest.delete(params[:id])
  end

  private

  def service_request_params
    params.require(:service_request).permit(:completed, :service_id, :provider_id, :user_id)
  end
end
