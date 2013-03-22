class Song < ActiveRecord::Base
  attr_accessible :author, :is_song, :title

  has_many :song_instances
  has_many :songs, :through => :song_instances

end
