ActiveAdmin.register Reading do
  filter :reporting_device_id, :as => :select, :collection => proc { ReportingDevice.all.map{|x| ["#{x.device_type_humanize} #{x.identifier}", x.id]}}
  filter :reading_time



end
