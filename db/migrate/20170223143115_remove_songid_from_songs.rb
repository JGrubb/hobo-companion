class RemoveSongidFromSongs < ActiveRecord::Migration
  def change
    remove_column :songs, :SongID
  end
end
