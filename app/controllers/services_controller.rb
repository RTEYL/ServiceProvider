class ServicesController < ApplicationController
  before_action :redirect_if_not_logged_in
  before_action :redirect_if_not_provider
  skip_before_action :redirect_if_not_provider, only: [:index]
  def index
    @services = Service.all
  end

  def new
    @provider = Provider.find_by_id(params[:provider_id])
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    if @service.save
      redirect_to provider_path(params[:provider_id])
    else
      render :new
    end
  end

  def edit
    @service = Service.find_by_id(params[:id])
    @provider = Provider.find_by_id(params[:provider_id])
    redirect_to @provider if !@service
  end

  def update
    @service = Service.find_by_id(params[:id])
    @provider = @service.provider
    if params[:commit] == 'Delete Service'
      destroy
    else
      @service.update(service_params)
    end
    redirect_to @provider
  end

  def destroy
    Service.delete(params[:id])
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
