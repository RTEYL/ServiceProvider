class ProvidersController < ApplicationController
 before_action :redirect_if_not_logged_in
 before_action :redirect_if_not_provider
  def show
    @provider = Provider.find_by_id(params[:id])
    @service = @provider.service
  end

  def edit
    @user = current_user
  end

  def update
    current_user.update(user_params)
    if current_user && !current_user.service_provider
      redirect_to current_user
    elsif current_user.service_provider
      User.delete(current_user.id)
      @user = Provider.new(user_params.except(:service_provider))
      session[:user_id] = @user.id if @user.save
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    User.delete(current_user.id)
    session.delete :user_id
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :service_provider)
  end

end
