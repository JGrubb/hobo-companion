class AddUpdatedByCreatedBy < ActiveRecord::Migration
  def up
    add_column :recordings, :updated_by, :integer
    add_column :recordings, :created_by, :integer
    add_column :shows, :created_by, :integer
    add_column :song_instances, :created_by, :integer
    add_column :song_instances, :updated_by, :integer
    add_column :songs, :created_by, :integer
    add_column :venues, :created_by, :integer
  end

  def down
    remove_column :recordings, :updated_by
    remove_column :recordings, :created_by
    remove_column :shows, :created_by
    remove_column :song_instances, :created_by
    remove_column :song_instances, :updated_by
    remove_column :songs, :created_by
    remove_column :venues, :created_by
  end
end
