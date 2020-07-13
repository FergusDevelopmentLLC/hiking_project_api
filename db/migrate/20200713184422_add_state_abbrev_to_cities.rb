class AddStateAbbrevToCities < ActiveRecord::Migration[6.0]
  def change
    add_column :cities, :state_abbrev, :string
  end
end
