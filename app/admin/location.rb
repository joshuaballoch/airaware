ActiveAdmin.register Location do

  filter :name
  filter :description
  filter :created_at

  index do
    selectable_column
    id_column
    column :name
    column :description
    column _("Reporting Devices") do |location|
      location.reporting_devices.map{|x| "Id: #{x.id}, Identifier: #{x.identifier}, Type: #{x.device_type_humanize}"}
    end
    column :user
    actions
  end

  form do |f|
    f.inputs "Location Details" do
      f.input :name
      f.input :description
      f.input :privacy, :as => :select, :collection => PrivacyEnumeration.to_a
      f.input :user
    end

    f.inputs "Team Members" do
      f.has_many :location_users, heading: _('Users') do |location_user|
        location_user.input :user_id, :label => _('User Name'), :as => :select, :collection => User.all.map{|u| ["#{u.username}", u.id] }
        location_user.input :role, :as => :select, :collection => LocationUserRole.to_a
        location_user.input :_destroy, :as => :boolean
      end
    end

    f.actions
  end

  show do |object|
    attributes_table do
      row :name
      row :description
      row :user
      row :created_at
      row :updated_at

      row _("Team Members") do
        workspace_links = object.location_users.map do |w|
          link_to "#{w.user.username} (type: #{w.role_humanize})", admin_user_path(w.user)

        end.join('<br/>')
        raw workspace_links
      end
    end
  end

end
