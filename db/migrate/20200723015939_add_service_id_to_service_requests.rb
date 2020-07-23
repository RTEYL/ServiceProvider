class AddServiceIdToServiceRequests < ActiveRecord::Migration[6.0]
  def change
    add_reference :service_requests, :service, foreign_key: true
  end
end
