class CreateRanks < ActiveRecord::Migration[6.1]
  def change
    create_table :ranks do |t|
      t.references :user
      t.references :rankable, polymorphic: true
      t.integer :messages_count, null: false, default: 0
      t.string :period

      t.timestamps
    end

    add_index :ranks, %i[rankable_type rankable_id user_id period], unique: true, name: 'index_user_rankable_with_period'
  end
end
