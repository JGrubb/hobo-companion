class AddInstrumentalToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :instrumental, :boolean
  end
end
