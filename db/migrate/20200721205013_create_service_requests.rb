class CreateServiceRequests < ActiveRecord::Migration[6.0]
  def change
    create_table :service_requests do |t|
      t.belongs_to :user, null: false, foreign_key: true
      t.belongs_to :provider, null: false, foreign_key: true
      t.boolean :completed

      t.timestamps
    end
  end
end
