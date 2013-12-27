class Show < ActiveRecord::Base
  attr_accessible :date, :show_notes, :venue_id, :versions_attributes
  extend FriendlyId
  friendly_id :date, use: :slugged

  belongs_to :venue
  
  has_many :versions, :dependent => :destroy, :order => :position
  has_many :songs, :through => :versions
  has_and_belongs_to_many :users

  validates :date, :venue_id, :presence => true
  validates :venue_id, :uniqueness => { :scope => :date, :message => "That show already exists." }
  
  accepts_nested_attributes_for :versions, :reject_if => lambda { |a| a[:song_id].blank? || a[:song_id].to_i < 1 }, :allow_destroy => true
  accepts_nested_attributes_for :venue

  def self.possible_sets
    ['1', '2', '3', 'Encore', '1st Encore', '2nd Encore']
  end
  
end
