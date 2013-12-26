class SongsController < ApplicationController
  before_filter :require_editor, :except => [:index, :show, :position_info]
  before_filter :user_shows, :only => :show
  
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
    @versions = SongInstance.where(:song_id => @song.id).joins(:show => :venue).select("venues.name as venue_name, shows.date as date, shows.id as show_id").order('shows.date asc').uniq { |v| v.show_id }
    @you_saw = 0
    @years_played = @versions.map { |v| v.date.year }.uniq.sort
    @position_info = Song.joins(:song_instances).select('song_instances.position, count(*) as count')
                        .where('songs.id = ?', @song.id).group('song_instances.position')
#    logger.debug @position_info.to_json
    if current_user
      @versions.each do |v|
        if @user_shows.include?(v.show_id)
          @you_saw += 1
        end
      end
    end
  end
  
  def position_info
    song_id = params[:id]
    @position_info = Song.joins(:song_instances).select('song_instances.position, count(*) as count')
                        .where('songs.id = ?', song_id).group('song_instances.position')
    render json: @position_info
  end

  def new
    @song = Song.new
  end

  def create
    @song = Song.new(params[:song])
    karma_check(@song, current_user, 50)
    @song.updated_by = current_user.id
    respond_to do |format|
      if @song.save
        format.html { redirect_to @song, notice:  "#{@song.title} was successfully created." }
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

  private

  def user_shows
    @user_shows = []
    if current_user 
      current_user.shows.each do |show|
        @user_shows << show.id
      end
    end
  end

end
