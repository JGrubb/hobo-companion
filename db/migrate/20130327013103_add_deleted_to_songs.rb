class AddDeletedToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :deleted, :boolean, :default => false
  end
end
