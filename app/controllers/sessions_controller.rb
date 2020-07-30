class SessionsController < ApplicationController
  def home
    redirect_to user_path(current_user.id) if current_user
  end
