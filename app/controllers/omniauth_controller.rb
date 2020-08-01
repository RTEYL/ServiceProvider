class OmniauthController < Devise::SessionsController

  def github
    @user = User.create_from_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      set_flash_message!(:notice, :signed_in) if is_navigational_format?
      sign_in_and_redirect @user
    else
      failure
    end
  end

  def failure
    flash[:danger] = 'There was a problem signing you in with Github, please try again'
    redirect_to new_user_registration_url
  end

end
