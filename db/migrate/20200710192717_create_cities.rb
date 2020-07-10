class CreateCities < ActiveRecord::Migration[6.0]
  def change
    create_table :cities do |t|
      t.string :name
      t.string :state
      t.string :country
      t.float :latitude
      t.float :longitude
      t.string :timezone
      t.integer :population

      t.timestamps
    end
  end
end
