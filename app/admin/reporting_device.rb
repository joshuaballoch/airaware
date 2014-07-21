ActiveAdmin.register ReportingDevice do

  filter :identifier
  filter :location
  filter :device_type
  scope :calibrated do
    ReportingDevice.joins(:calibrations).where("calibrations.id is not null")
  end
  index do
    selectable_column
    id_column
    column :identifier
    column :device_type do |device|
      device.device_type_humanize
    end
    column :label
    column :calibrated do |device|
      device.calibrations.first ? true : false
    end
    column :location do |device|
      link_to device.location.name, admin_location_path(device.location.id)
    end
    column :created_at
    actions
  end

  form do |f|
    f.inputs "Reporting Device Details " do
      f.input :identifier
      f.input :label

      f.input :device_type, :as => :select, :collection => ReportingDeviceType.to_a
      f.input :location, :as => :select, :collection => Location.all.map{|l| ["#{l.name}", l.id]}
    end
    f.inputs "Calibrations" do
      f.has_many :calibrations, heading: _("Reading Calibrations") do |calibration|
        calibration.input :calibration_property, :label => _("Property to Calibrate"), :as => :select, :collection => CalibrationProperty.to_a
        calibration.input :calibration_type, :label => _("Type of Calibration"), :as => :select, :collection => CalibrationType.to_a
        calibration.input :a, :label => "Factor a"
        calibration.input :b, :label => "Factor b"
        calibration.input :c, :label => "Factor c"
        calibration.input :_destroy, :as => :boolean
      end
    end
    f.actions
  end

  show do |object|
    attributes_table do
      row :id
      row :location
      row :label
      row :device_type do
        object.device_type_humanize
      end
      row _("Calibrations") do
        object.calibrations.map do |w|
          "property: #{w.calibration_property_humanize} (type: #{w.calibration_type_humanize}) a: #{w.a} b: #{w.b} c: #{w.c}"

        end.join('<br/>')
      end
    end
  end
end
