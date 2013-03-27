class AddDefaultToIsSongOnSongs < ActiveRecord::Migration
  def change
    change_column :songs, :is_song, :boolean, :default => true
  end
end
