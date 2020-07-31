class RegistrationOverrideController < Devise::RegistrationsController

  protected

  def update_resource(resource, params)
    if !resource.provider.blank?
      resource.update_without_password(params)
    else
      resource.update_with_password(params)
    end
  end

  def account_update_params
     if params[:user].include?(:service_provider)
        params.require(:user).permit(:email, :service_provider)
     else
      super
     end
  end

end