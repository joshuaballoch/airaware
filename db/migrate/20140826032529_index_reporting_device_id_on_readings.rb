class IndexReportingDeviceIdOnReadings < ActiveRecord::Migration
  def up
  	add_index :readings, :reporting_device_id
  end

  def down
  	remove_index :readings, :reporting_device_id
  end
end
