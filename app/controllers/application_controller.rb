class ApplicationController < ActionController::Base
  protect_from_forgery
  helper_method :current_user, :logged_in?, :custom_error_messages

  def redirect_if_not_logged_in
    if !user_signed_in?
      redirect_to root_path
      flash[:warning] = "Log in or Sign up to view that page"
    end
  end

  def redirect_if_not_provider
    redirect_to user_path(current_user.id) if !current_user.service_provider
  end

  def custom_error_messages(type, object)
    flash[:"#{type}"] = object.errors.full_messages.join(", ")
  end

end
