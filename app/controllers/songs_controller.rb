class SongsController < ApplicationController
  def index
    @songs = Song.order(:title)
  end

  def show
    @song = Song.find(params[:id])
    @versions = SongInstance.where(:song_id => @song.id).joins(:show).order(:date).includes(:show)
  end

  def new
  end

  def create
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
