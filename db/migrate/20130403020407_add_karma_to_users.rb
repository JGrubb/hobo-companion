class AddKarmaToUsers < ActiveRecord::Migration
  def change
    add_column :users, :karma, :integer, :default => 10
  end
end
