class AddDeviceTypeToReportingDevices < ActiveRecord::Migration
  def change
    add_column :reporting_devices, :device_type, :integer, :null => false
  end
end
