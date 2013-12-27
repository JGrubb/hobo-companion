class AddDefaultSetToVersions < ActiveRecord::Migration
  def change
    change_column :song_instances, :set_number, :string, :default => "1"
  end
end
