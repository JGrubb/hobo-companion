class CreateShowsUsersTable < ActiveRecord::Migration
  def up
    create_table :shows_users, :id => false do |t|
      t.references :shows, :users
    end
    add_index :shows_users, [:shows_id, :users_id]
  end

  def down
    drop_table :shows_users
  end
end
