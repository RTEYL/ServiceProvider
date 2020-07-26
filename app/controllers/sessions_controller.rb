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
      user = User.find_by(id: auth_hash[:uid], first_name: auth_hash[:info][:nickname])
      user = User.create(id: auth_hash[:uid], first_name: auth_hash[:info][:nickname], password: SecureRandom.uuid) if !user
      session[:user_id] = user.id
    if user
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
