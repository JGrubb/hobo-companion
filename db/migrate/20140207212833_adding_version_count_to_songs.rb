class AddingVersionCountToSongs < ActiveRecord::Migration
  def up
    add_column :songs, :versions_count, :integer, default: 0
    ids = []
    Song.all.each { |s| ids << s.id }
    ids.each do |song_id|
      Song.reset_counters(song_id, :versions)
    end
  end

  def down
    remove_column :songs, :versions_count
  end
end
