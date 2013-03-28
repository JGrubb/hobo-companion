class DropLegacyTables < ActiveRecord::Migration
  def up
    drop_table :song_int_copy
    drop_table :song_instances_old
  end

  def down
  end
end
