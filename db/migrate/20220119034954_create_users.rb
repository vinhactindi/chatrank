class CreateUsers < ActiveRecord::Migration[6.1]
  def change
    create_table :users do |t|
      t.string :username, null: false
      t.string :discriminator, null: false
      t.string :avatar_url

      t.timestamps
    end
  end
end
