class AddUpdatingToServers < ActiveRecord::Migration[6.1]
  def change
    add_column :servers, :updating, :boolean, default: false
  end
end
