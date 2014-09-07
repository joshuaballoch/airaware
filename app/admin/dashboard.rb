ActiveAdmin.register_page "Dashboard" do

  menu priority: 1, label: proc{ I18n.t("active_admin.dashboard") }

  sidebar :links do
    ul do
      li link_to "Sidekiq (processing queue)", admin_sidekiq_web_path
    end
  end

  content title: proc{ I18n.t("active_admin.dashboard") } do

    columns do
      column do
        panel "Active Locations Status" do
          render partial: 'status', locals: {locations: Location.includes(:reporting_devices, :admin_watchers).active}
        end
      end
    end
  end # content
end
