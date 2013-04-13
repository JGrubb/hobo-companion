class CreateRecordings < ActiveRecord::Migration
  def change
    create_table :recordings do |t|
      t.reference :show_id
      t.text :playlist

      t.timestamps
    end
  end
end
