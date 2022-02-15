class AddIconToServers < ActiveRecord::Migration[6.1]
  def change
    add_column :servers, :icon_url, :string
  end
end
