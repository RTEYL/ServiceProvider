class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :logged_in?

  def current_user
    @current_user ||= User.find_by_id(session[:user_id])
  end

  def logged_in?
    !!session[:user_id]
  end

  def redirect_if_not_logged_in
    redirect_to root_path if !logged_in?
  end

  def redirect_if_not_provider
    !current_user.service_provider
  end

end
