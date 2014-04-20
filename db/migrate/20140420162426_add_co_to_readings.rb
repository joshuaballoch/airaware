class AddCoToReadings < ActiveRecord::Migration
  def change
    add_column :readings, :co, :float
  end
end
