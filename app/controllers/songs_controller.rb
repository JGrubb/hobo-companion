class SongsController < ApplicationController
  before_filter :require_editor, :except => [:index, :show]
  
  def index
    @songs = Song.order(:title).where(:is_song => true).where(:deleted => false)
  end

  def show
    @song = Song.find(params[:id])
    @title = @song.title
    @description = "Info and lyrics for #{@song.title}, Railroad Earth."
    @versions = SongInstance.where(:song_id => @song.id).joins(:show).order(:date)
  end

  def new
    @song = Song.new
  end

  def create
    @song.new(params[:song])
    User.bump_karma(50, current_user)
    @song.updated_by = current_user.id
    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice:  "#{@song.title} was successfully updated." }
        format.json { render json: @song }
      else
        format.html { render action: "new" }
        format.json { render json: @song.errors, status: :unprocessable_entity }
      end
    end
  end

  def edit
    @song = Song.find(params[:id])
  end

  def update
    @song = Song.find(params[:id])
    unless @song.updated_by == current_user.id
      User.bump_karma(25, current_user)
      @song.updated_by = current_user.id
    end
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
    @song.destroy
    redirect_to songs_path
  end
  
  def soft_delete
    @song = Song.find(params[:song_id])
    @song.deleted = true
    @song.save
    redirect_to songs_path
  end
  
  def deleted_songs
    @songs = Song.where(:deleted => true)
    User.bump_karma(10, current_user)
    render :index
  end
end
