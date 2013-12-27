class RenameSongInstances < ActiveRecord::Migration
  def change
    rename_table :song_instances, :versions
  end
end
