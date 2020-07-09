class CreateTrails < ActiveRecord::Migration[6.0]
  def change
    create_table :trails do |t|
      t.integer :hiking_project_id
      t.string :name
      t.string :trail_type
      t.string :summary
      t.string :difficulty
      t.float :stars
      t.integer :starVotes
      t.string :location
      t.string :url
      t.string :imgSqSmall
      t.string :imgSmall
      t.string :imgSmallMed
      t.string :imgMedium
      t.float :length
      t.integer :ascent
      t.integer :descent
      t.integer :high
      t.integer :low
      t.float :longitude
      t.float :latitude
      t.string :conditionStatus
      t.string :conditionDetails
      t.date :conditionDate
      t.string :features
      t.string :overview
      t.string :description

      t.timestamps
    end
  end
end
