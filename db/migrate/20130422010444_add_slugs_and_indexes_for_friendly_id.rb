class AddSlugsAndIndexesForFriendlyId < ActiveRecord::Migration
  def up
    add_column :songs, :slug, :string
    add_index :songs, :slug, :unique => true
    add_column :shows, :slug, :string
    add_index :shows, :slug, :unique => true
  end

  def down
  end
end
