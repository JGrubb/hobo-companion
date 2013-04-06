class Show < ActiveRecord::Base
  attr_accessible :date, :show_notes, :venue_id, :song_instances_attributes

  belongs_to :venue
  
  has_many :song_instances, :dependent => :delete_all, :order => :position
  has_many :songs, :through => :song_instances

  validates :date, :venue_id, :presence => true
  
  accepts_nested_attributes_for :song_instances, :reject_if => lambda { |a| a[:song_id].blank? }, :allow_destroy => true
  accepts_nested_attributes_for :venue
  
  after_save { |show| ArchiveWorker.perform_async(show.id) }
end