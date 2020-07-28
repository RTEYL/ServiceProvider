class UpdateSessions < ActiveRecord::Migration[6.0]
  def change
    add_column(:sessions, :session_id, :string, null: false)
    add_column(:sessions, :data, :text)
    add_index(:sessions, :session_id, unique: true)
    add_index(:sessions, :updated_at)
  end
end
