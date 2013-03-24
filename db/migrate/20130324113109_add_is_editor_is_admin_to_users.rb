class AddIsEditorIsAdminToUsers < ActiveRecord::Migration
  def change
    add_column :users, :is_admin, :boolean
    add_column :users, :is_editor, :boolean
  end
end
