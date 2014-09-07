class CreateLocationAdminWatchers < ActiveRecord::Migration
  def change
    create_table :location_admin_watchers do |t|
      t.integer :user_id
      t.integer :location_id

      t.timestamps
    end

    add_index :location_admin_watchers, [:user_id, :location_id], :unique => true
    add_index :location_admin_watchers, :location_id
  end
end
