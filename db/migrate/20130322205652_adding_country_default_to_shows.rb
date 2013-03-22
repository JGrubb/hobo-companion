class AddingCountryDefaultToShows < ActiveRecord::Migration
  def up
    change_column :venues, :country, :string, :default => 'USA'
  end

  def down
    change_column :venues, :country, :string, :default => NULL
  end
end
