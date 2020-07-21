class CreateServices < ActiveRecord::Migration[6.0]
  def change
    create_table :services do |t|
      t.belongs_to :provider, null: false, foreign_key: true
      t.string :type
      t.text :description

      t.timestamps
    end
  end
end
