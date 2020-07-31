class AddDetailViewsToTrails < ActiveRecord::Migration[6.0]
  def change
    add_column :trails, :detail_views, :integer, :default => 0
  end
end
