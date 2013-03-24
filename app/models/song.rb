class Song < ActiveRecord::Base
  attr_accessible :author, :is_song, :title

  has_many :song_instances, :dependent => :delete_all
  has_many :shows, :through => :song_instances

end
