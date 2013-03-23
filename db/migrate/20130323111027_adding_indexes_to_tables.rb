class AddingIndexesToTables < ActiveRecord::Migration
  def up
    add_index :song_instances, :show_id, :name => "index_on_show_id"
    add_index :song_instances, :song_id, :name => "index_on_song_id"
  end

  def down
    remove_index :song_instances, :show_id
    remove_index :song_instances, :song_id
  end
end
