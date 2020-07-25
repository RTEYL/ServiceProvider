class AddColumnCreatorIdToServiceRequests < ActiveRecord::Migration[6.0]
  def change
    add_column :service_requests, :creator_id, :integer
    add_index :service_requests, :creator_id
  end
end
