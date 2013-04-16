class CreateRecordings < ActiveRecord::Migration
  def change
    create_table :recordings do |t|
      t.references :show_id
      t.text :playlist

      t.timestamps
    end
  end
end
