class AddDataOptionsToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :temperature, :boolean, :default => true
    add_column :locations, :humidity, :boolean, :default => true
    add_column :locations, :hcho, :boolean, :default => true
    add_column :locations, :co2, :boolean, :default => true
    add_column :locations, :tvoc, :boolean, :default => true
    add_column :locations, :pm2p5, :boolean, :default => true
  end
end
