class AddReadingTimeIndexToReadings < ActiveRecord::Migration
  def change
  	add_index :readings, [:reading_time, :reporting_device_id]
  	add_index :readings, :reading_time
  end
end
