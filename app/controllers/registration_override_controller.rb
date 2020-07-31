class RegistrationOverrideController < Devise::RegistrationsController

  protected

  def update_resource(resource, params)
    if !resource.provider.blank?
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end

  def sign_up_params
    if params[:user].include?(:service_provider)
      user_params
   else
    super
   end
  end

  def account_update_params
     if params[:user].include?(:service_provider)
      user_params
     else
      super
     end
  end

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :service_provider, :password, :password_confirmation)
  end

end