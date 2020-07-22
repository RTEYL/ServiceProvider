class ServicesController < ApplicationController
  before_action :redirect_if_not_logged_in

  def index
    @services = Service.all
  end

  def new
    redirect_if_not_provider
    @provider = Provider.find_by_id(params[:provider_id])
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    if @service.save
      redirect_to provider_service_path(params[:provider_id], @service)
    else
      render :new
    end
  end

  private

  def service_params
    if params[:provider_id] == params[:service][:provider_id]
      params.require(:service).permit(:service_type, :description, :provider_id)
    else
      redirect_to new_provider_service_path(params[:provider_id])
    end
  end
end
