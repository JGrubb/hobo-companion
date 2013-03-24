class Show < ActiveRecord::Base
  attr_accessible :date, :show_notes, :venue_id

  belongs_to :venue
  
  has_many :song_instances, :dependent => :delete_all
  has_many :songs, :through => :song_instances

  validates :date, :venue_id, :presence => true
end
