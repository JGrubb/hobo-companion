class FixUsersShowsTable < ActiveRecord::Migration
  def up
    rename_column :shows_users, :shows_id, :show_id
    rename_column :shows_users, :users_id, :user_id
  end

  def down
    rename_column :shows_users, :show_id, :shows_id
    rename_column :shows_users, :user_id, :users_id
  end
end
