class Show < ActiveRecord::Base
  attr_accessible :date, :show_notes, :venue_id, :song_instances_attributes
  extend FriendlyId
  friendly_id :date, :use => :slugged

  belongs_to :venue
  
  has_many :song_instances, :dependent => :delete_all, :order => :position
  has_many :songs, :through => :song_instances

  validates :date, :venue_id, :presence => true
  validates :venue_id, :uniqueness => { :scope => :date, :message => "That show already exists." }
  
  accepts_nested_attributes_for :song_instances, :reject_if => lambda { |a| a[:song_id].blank? || a[:song_id].to_i < 1 }, :allow_destroy => true
  accepts_nested_attributes_for :venue
  
end
