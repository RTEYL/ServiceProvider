class DropProvidersTable < ActiveRecord::Migration[6.0]
  def change
    drop_table :providers
  end
end
