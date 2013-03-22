class Venue < ActiveRecord::Base
  attr_accessible :city, :country, :name, :state
  has_many :shows

  validates :name, :city, :state, :presence => :true
end
