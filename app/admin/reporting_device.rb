ActiveAdmin.register ReportingDevice do

  index do
    selectable_column
    id_column
    column :identifier
    column :device_type do |device|
      device.device_type_humanize
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

      f.input :device_type, :as => :select, :collection => ReportingDeviceType.to_a
      f.input :location, :as => :select, :collection => Location.all.map{|l| ["#{l.name}", l.id]}
    end
    f.actions
  end
end
