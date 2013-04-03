class SongsController < ApplicationController
  before_filter :require_editor, :except => [:index, :show]
  
  def index
    @songs = Song.order(:title).where(:is_song => true)
  end

  def show
    @song = Song.find(params[:id])
    @versions = SongInstance.where(:song_id => @song.id).joins(:show).order(:date)
  end

  def new
    @song = Song.new
    
    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @song }
    end
  end

  def create
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])
    respond_to do |format|
      if @song.update_attributes(params[:song])
        format.html { redirect_to @song, notice:  "#{@song.title} was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @song = Song.find(params[:id])
    if @song.destroy
      redirect_to songs_path
    end
  end
end
