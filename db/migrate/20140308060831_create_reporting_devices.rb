class CreateReportingDevices < ActiveRecord::Migration
  def change
    create_table :reporting_devices do |t|
      t.integer :location_id
      t.string  :identifier

      t.timestamps
    end
  end
end
