class UsersController < ApplicationController
  before_action :redirect_if_not_logged_in

  def show
    @user = current_user
    @service = @user.service if @user.service
  end

end
