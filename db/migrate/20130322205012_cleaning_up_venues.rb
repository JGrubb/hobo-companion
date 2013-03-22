class CleaningUpVenues < ActiveRecord::Migration
  def up
    change_column :venues, :name, :string, :limit => 255
    change_column :venues, :city, :string, :limit => 255
    change_column :venues, :state, :string, :limit => 255
    change_column :venues, :country, :string, :limit => 255
  end

  def down
    change_column :venues, :name, :string, :limit => 100
    change_column :venues, :city, :string, :limit => 100
    change_column :venues, :state, :string, :limit => 100
    change_column :venues, :country, :string, :limit => 100
  end
end
