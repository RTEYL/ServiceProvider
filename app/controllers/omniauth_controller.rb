class OmniauthController < ApplicationController

  def github
    @user = User.create_from_provider_data(request.env['omniauth.auth'])
    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'Github') if is_navigational_format?
    else
      failure
    end
  end

  def failure
    flash[:error] = 'Ther was a problem signing you in with Github, please try again'
    redirect_to new_user_registration_url
  end

end
