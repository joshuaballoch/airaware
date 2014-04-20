class AddPrivacyToLocations < ActiveRecord::Migration
  def change
    add_column :locations, :privacy, :integer, :null => false, :default => 0
  end
end
