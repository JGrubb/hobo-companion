class AddUpdatingUserToTables < ActiveRecord::Migration
  def change
    add_column :shows, :updated_by, :integer
    add_column :songs, :updated_by, :integer
    add_column :venues, :updated_by, :integer
  end
end
