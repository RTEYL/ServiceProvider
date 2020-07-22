class ServicesController < ApplicationController
  before_action :redirect_if_not_logged_in

  def index
    @services = Service.all
  end

  def new
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
  end

  private

  def service_params
    params.require(:service).permit(:type, :description, :provider_id)
  end
end
