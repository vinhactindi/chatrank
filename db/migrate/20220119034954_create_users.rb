class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :uid, null: false
      t.string :provider, null: false
      t.string :username, null: false
      t.string :discriminator, null: false
      t.string :avatar_url

      t.timestamps
    end

    add_index :users, %i[provider uid], unique: true
  end
end
