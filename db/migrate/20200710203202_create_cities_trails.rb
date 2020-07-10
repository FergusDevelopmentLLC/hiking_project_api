class CreateCitiesTrails < ActiveRecord::Migration[6.0]
  def change
    create_table :cities_trails do |t|
      t.integer :city_id
      t.integer :trail_id

      t.timestamps
    end
  end
end
