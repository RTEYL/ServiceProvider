class RemoveProviderIdFromServiceRequests < ActiveRecord::Migration[6.0]
  def change
    remove_column :service_requests, :provider_id
  end
end
