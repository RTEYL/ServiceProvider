class UsersController < ApplicationController
  before_action :redirect_if_not_logged_in
  skip_before_action :redirect_if_not_logged_in, only: [:new, :create]
  def new
    redirect_to user_path(current_user.id) if logged_in?
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to @user
    else
      render :new
    end
  end

  def show
    @user = current_user
    @service = @user.service if @user.service
  end

  def edit
    @user = current_user
    if @user.service_provider
      render '_provider_edit'
    end
  end

  def update
    current_user.update(user_params)
    if current_user
      redirect_to current_user
    else
      render :edit
    end
  end

  def destroy
    User.delete(params[:user_id])
    session.delete :user_id
    redirect_to root_path
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :service_provider)
  end

end
