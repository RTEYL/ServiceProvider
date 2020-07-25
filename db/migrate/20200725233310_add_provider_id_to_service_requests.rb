class AddProviderIdToServiceRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :service_requests, :provider_id, :integer
  end
end
