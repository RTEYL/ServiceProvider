class ProvidersController < ApplicationController
 before_action :redirect_if_not_logged_in
 before_action :redirect_if_not_provider
  def show
    @provider = Provider.find_by_id(params[:id])
    @service = @provider.service
  end

end
