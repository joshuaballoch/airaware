class CreateCalibrations < ActiveRecord::Migration
  def change
    create_table :calibrations do |t|
      t.integer :reporting_device_id
      t.integer :calibration_type
      t.integer :calibration_property
      t.float   :a
      t.float   :b
      t.float   :c
      t.float   :d
      t.float   :e
      t.float   :f
      t.float   :g

      t.timestamps
    end

    add_index :calibrations, [:reporting_device_id, :calibration_property], :unique => true, :name => :reporting_device_calibration_uniqueness
  end
end
