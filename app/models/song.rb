class Song < ActiveRecord::Base
  attr_accessible :author, :is_song, :title, :notes, :instrumental
  extend FriendlyId
  friendly_id :title, :use => :slugged

  has_many :song_instances, :dependent => :delete_all
  has_many :shows, :through => :song_instances

  validates :title, :presence => true

end
