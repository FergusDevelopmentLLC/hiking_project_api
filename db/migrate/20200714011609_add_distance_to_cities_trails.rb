class AddDistanceToCitiesTrails < ActiveRecord::Migration[6.0]
  def change
    add_column :cities_trails, :distance, :float
  end
end
