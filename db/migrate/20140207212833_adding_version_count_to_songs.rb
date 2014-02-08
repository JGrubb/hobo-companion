class AddingVersionCountToSongs < ActiveRecord::Migration
  def change
    add_column :songs, :version_count, :integer, default: 0
  end
end
