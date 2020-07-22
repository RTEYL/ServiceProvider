class ProvidersController < ApplicationController
 before_action :redirect_if_not_logged_in
  def show
    @provider = Provider.find_by_id(params[:id])
  end

end
