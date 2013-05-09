class FixRecordingsTable < ActiveRecord::Migration
  def up
    remove_column :recordings, :updated_by
    remove_column :recordings, :created_by
    rename_column :recordings, :show_id_id, :show_id
  end

  def down
    add_column :recordings, :updated_by, :integer
    add_column :recordings, :created_by, :integer
    rename_column :recordings, :show_id, :show_id_id
  end
end
