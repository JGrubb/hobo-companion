class SongsController < ApplicationController
  before_filter :require_editor, :except => [:index, :show]
  
  def index
    @songs = Song.joins(:song_instances)
                .select('songs.title, songs.slug, songs.notes, songs.instrumental, count(*) as count')
                .where(:is_song => true)
                .group('songs.id')
                .order('songs.title asc')
  end

  def show
    @song = Song.find(params[:id])
    @title = @song.title
    @description = "Info and lyrics for #{@song.title}, Railroad Earth."
    @versions = SongInstance.where(:song_id => @song.id).joins(:show => :venue).select("song_instances.*, venues.name as venue_name, shows.*").includes(:show).order('shows.date asc')
  end

  def new
    @song = Song.new
  end

  def create
    @song.new(params[:song])
    karma_check(@song, current_user, 50)
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
    karma_check(@song, current_user, 25)
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
