class CreateReadings < ActiveRecord::Migration
  def change
    create_table :readings do |t|
      # Relate a reading and a reporting device
      t.integer  :reporting_device_id

      # Scientific Readings Fields
      t.float    :temperature
      t.float    :humidity
      t.float    :hcho
      t.float    :co2
      t.float    :tvoc
      t.float    :pm2p5

      # Time Fields
      t.datetime :reading_time
      t.timestamps
    end
  end
end
