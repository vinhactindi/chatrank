class AddLastSeenToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :last_seen_server_id, :bigint
  end
end
