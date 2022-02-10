class CreateGuilds < ActiveRecord::Migration[6.1]
  def change
    create_table :guilds do |t|
      t.belongs_to :server
      t.belongs_to :user
      t.integer :permissions

      t.timestamps
    end
  end
end
