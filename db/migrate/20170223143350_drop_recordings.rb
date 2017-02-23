class DropRecordings < ActiveRecord::Migration
  def up
    drop_table :recordings
  end
  def down
    create_table :recordings do |t|
      t.references :show_id
      t.text :playlist

      t.timestamps
    end
  end
end
