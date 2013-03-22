class CleaningUpSongsTable < ActiveRecord::Migration
  def up
    change_column :songs, :title, :string, :length => 128
    change_column :songs, :author, :string, :length => 128
  end

  def down
    change_column :songs, :title, :string, :length => 100
    change_column :songs, :author, :string, :length => 100
  end
end
