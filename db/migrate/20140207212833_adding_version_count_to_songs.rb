class AddingVersionCountToSongs < ActiveRecord::Migration
  def up
    add_column :songs, :versions_count, :integer, default: 0
    ids = Set.new
    Song.where(is_song: true).each { |s| ids << s.id }
    ids.each do |song_id|
      Song.reset_counters(song_id, :versions)
    end
  end

  def down
    remove_column :songs, :versions_count
  end
end
