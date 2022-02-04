class CreateChannels < ActiveRecord::Migration[6.1]
  def change
    create_table :channels do |t|
      t.string :name
      t.integer :channel_type
      t.integer :position
      t.bigint :parent_id
      t.references :server, null: false, foreign_key: true

      t.timestamps
    end

    add_index :channels, :parent_id
  end
end
