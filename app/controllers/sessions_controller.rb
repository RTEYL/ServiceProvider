class SessionsController < ApplicationController
  skip_before_action :verify_authenticity_token, only: :create
  require 'securerandom'
  def home
    redirect_to current_user if current_user
  end

  def create
    auth_hash ? auth_loggin : user_loggin
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end

  private

  def auth_hash
    request.env['omniauth.auth']
  end

  def auth_loggin
    @user = User.where(uid: auth_hash[:uid], provider: auth_hash[:provider]).first_or_create
    if user
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      redirect_to login_path
    end
  end

  def user_loggin
    user = User.find_by(email: params[:user][:email])
    user.authenticate(params[:user][:password])
    if user.save
      session[:user_id] = user.id
      redirect_to user_path(user)
    else
      redirect_to login_path
    end
  end

end
