class UsersController < ApplicationController
  before_action :redirect_if_not_logged_in
  skip_before_action :redirect_if_not_logged_in, only: [:new, :create]
  def new
    @user = User.new
  end

  def create

    @user = User.new(user_params)
    @user = Provider.new(user_params.except(:service_provider)) if @user.service_provider
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @user = current_user
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
