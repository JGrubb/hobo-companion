class SongInstance < ActiveRecord::Base
  attr_accessible :position, :set_number, :show_id, :song_id, :song_notes, :transition

  belongs_to :show
  belongs_to :song
end
