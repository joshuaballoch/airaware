class AddLabelToReportingDevices < ActiveRecord::Migration
  def change
    add_column :reporting_devices, :label, :string
  end
end
