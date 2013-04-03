class AddVerifiedToShows < ActiveRecord::Migration
  def change
    add_column :shows, :verified, :boolean
    add_index :shows, :verified
  end
end
