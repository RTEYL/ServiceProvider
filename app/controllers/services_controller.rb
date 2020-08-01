class ServicesController < ApplicationController
  before_action :redirect_if_not_logged_in
  before_action :redirect_if_not_provider
  skip_before_action :redirect_if_not_provider, only: [:index]
  def index
    @services = Service.search(params[:search])
  end

  def new
    @user = current_user
    @service = Service.new
  end

  def create
    @service = Service.new(service_params)
    @user = current_user
    if @service.save
      redirect_to current_user
      flash[:notice] = "Your service is now listed"
    else
      custom_error_messages('alert', @service)
      render :new
    end
  end

  def edit
    @service = Service.find_by_id(params[:id])
    @user = current_user
    redirect_to current_user if !@service
  end

  def update
    @service = Service.find_by_id(params[:id])
    @user = @service.user
    if params[:commit] == 'Delete Service'
      destroy
      flash[:notice] = "Your service has been removed"
    elsif @service.update(service_params)
      flash[:notice] = "Your service is now updated"
      redirect_to @user
    else
      custom_error_messages("alert", @service)
      redirect_to @user
    end
  end

  def destroy
    Service.delete(params[:id])
  end

  private

  def service_params
    if params[:user_id] == params[:service][:user_id]
      params.require(:service).permit(:service_type, :description, :user_id)
    else
      redirect_to new_user_service_path(params[:user_id])
    end
  end
end
