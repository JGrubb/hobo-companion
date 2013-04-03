class AddVerifiedToShows < ActiveRecord::Migration
  def change
    add_column :shows, :verified, :boolean, :default => false
    add_index :shows, :verified
  end
end
