class AddingTimestamps < ActiveRecord::Migration
  def up
    add_column :shows, :created_at, :datetime
    add_column :shows, :updated_at, :datetime
    add_column :songs, :created_at, :datetime
    add_column :songs, :updated_at, :datetime
    add_column :song_instances, :created_at, :datetime
    add_column :song_instances, :updated_at, :datetime
    add_column :venues, :created_at, :datetime
    add_column :venues, :updated_at, :datetime
  end

  def down
    remove_column :shows, :created_at
    remove_column :shows, :updated_at
    remove_column :songs, :created_at
    remove_column :songs, :updated_at
    remove_column :song_instances, :created_at
    remove_column :song_instances, :updated_at
    remove_column :venues, :created_at
    remove_wolumn :venues, :updated_at
  end
end