class AddArchiveInfoToShows < ActiveRecord::Migration
  def change
    add_column :shows, :archive_info, :text
  end
end
