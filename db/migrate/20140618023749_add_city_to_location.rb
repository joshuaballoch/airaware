class AddCityToLocation < ActiveRecord::Migration
  def change
    add_column :locations, :city, :integer
  end
end
