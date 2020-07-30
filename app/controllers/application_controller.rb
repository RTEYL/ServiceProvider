class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :logged_in?

  def after_sign_in_path_for(resource)
   user_path(current_user.id)
  end

  def redirect_if_not_logged_in
    redirect_to root_path if !user_signed_in?
  end

  def redirect_if_not_provider
    !current_user.service_provider
  end

end
