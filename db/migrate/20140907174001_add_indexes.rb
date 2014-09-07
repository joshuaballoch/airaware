class AddIndexes < ActiveRecord::Migration
  def up
    add_index :reporting_devices, :identifier
    add_index :reporting_devices, [:identifier, :device_type], :unique => true
    add_index :reporting_devices, :location_id
  end

  def down
    remove_index :reporting_devices, :identifier
    remove_index :reporting_devices, [:identifier, :device_type]
    remove_index :reporting_devices, :location_id
  end
end
