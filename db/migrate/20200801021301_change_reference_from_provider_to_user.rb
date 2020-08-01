class ChangeReferenceFromProviderToUser < ActiveRecord::Migration[6.0]
  def change
    if foreign_key_exists?(:services, :providers)
      remove_foreign_key :services, :providers
      add_foreign_key :services, :users
    end
  end
end
