class AddVenueIdIndexToShows < ActiveRecord::Migration
  def change
    add_index :shows, :venue_id
  end
end
