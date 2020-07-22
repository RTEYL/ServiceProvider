class SessionsController < ApplicationController

  def home
    redirect_to current_user if current_user
  end

  def create
    user = user_or_provider
    if user && user.authenticate(params[:user][:password])
      session[:user_id] = user.id
      redirect_to user
    else
      redirect_to login_path
    end
  end

  def destroy
    session.delete :user_id
    redirect_to root_path
  end

  private

  def user_or_provider
    if  user = User.find_by(email: params[:user][:email])
      user
    elsif provider = Provider.find_by(email: params[:user][:email])
      provider
    else
      nil
    end
  end

end
