class CreateLocationUsers < ActiveRecord::Migration
  def change
    create_table :location_users do |t|
      t.integer :user_id
      t.integer :location_id
      t.integer :role

      t.timestamps
    end

    add_index :location_users, [:user_id, :location_id], :unique => true
  end
end
