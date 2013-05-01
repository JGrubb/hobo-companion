class ShowsController < ApplicationController
  before_filter :require_user, :except => [:show, :index, :welcome]
  caches_page :index
  
  require 'yaml'
  
  def index
    @shows = Show.joins(:venue).select('shows.*, venues.name, venues.city, venues.state').sort { |s, t| t.date <=> s.date }
    @description = "The definitive site for Railroad Earth community, RRE lyrics, show and lsetlist information, an who knows what else to come..."
    respond_to do |format|
      format.html
      format.json { render :json => @shows }
    end
  end

  def show
    @show = Show.joins(:venue).select('shows.*, venues.name, venues.city, venues.state, venues.id as venue_id').find(params[:id])
    @possible_sets = SongInstance.select(:set_number).uniq.order('set_number ASC')
    @songs = SongInstance.joins(:song)
              .order('song_instances.position ASC')
              .select('song_instances.position, song_instances.set_number, song_instances.transition, song_instances.song_notes, songs.title, songs.is_song, songs.id')
              .where(:show_id => @show.id)
    @title = "Setlist for #{@show.date}"
    @description = "Show and setlist info for Railroad Earth on #{@show.date} at #{@show.name} - #{@show.city}, #{@show.state}"
    if @show.archive_info
      @archive_info = Psych.load(@show.archive_info)
    end
  end

  def new
    @venue = Venue.new
    @show = Show.new
    @show.song_instances.build
    load_sets
    @venues = Venue.all
  end

  def create
    @show = Show.new(params[:show])
    songs = params[:show][:song_instances_attributes]
    check_song_id_for_new(songs, params)
    karma_check(@show, current_user, 100)
    @show.updated_by = current_user.id
    if @show.save
      ArchiveWorker.perform_async(@show.id)
      expire_page :action => :index
      redirect_to @show
    else
      redirect_to shows_path
    end
  end

  def edit
    @show = Show.find(params[:id])
    @venue = @show.venue
    @show.song_instances.build
    load_sets
  end

  def update
    @show = Show.find(params[:id])
    songs = params[:show][:song_instances_attributes]
    check_song_id_for_new(songs, params)
    karma_check(@show, current_user, 25)
    respond_to do |format|
      if @show.update_attributes(params[:show])
        ArchiveWorker.perform_async(@show.id)
        expire_page :action => :index
        format.html { redirect_to @show, info:  "#{@show.date} was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @show.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @show = Show.find(params[:id])
    if @show.destroy
      redirect_to shows_path
      expire_page :action => :index
    end
  end


  def year
    @shows = Show.where('extract(year from date) = ?', params[:year]).includes(:venue)
    render :index
  end

  def welcome
    @shows = Show.joins(:venue).select('shows.*, venues.name, venues.city, venues.state').sort { |s, t| s.date <=> t.date }
    @most_recent = @shows.last
    @recently_added = @shows.select { |s| s.created_at }.sort { |s, t| s.created_at <=> t.created_at}.slice(-5..-1).reverse
    @first_show = @shows.first
    @recently_updated_songs = Song.order('updated_at desc').limit(5)
    @years = @shows.map { |s| s.date.year }.uniq.sort
    respond_to do |format|
      format.html
      format.json { render :json => @shows}
    end
  end
  
  private
  
  def check_song_id_for_new(songs, params)
    songs.each do |song|
      if (song[1][:song_id].empty? || song[1][:song_id].to_i == 0)
        tune = Song.find_or_create_by_title(song[1][:song_id])
        params[:show][:song_instances_attributes][song[0]][:song_id] = tune.id
      end
    end
  end
  
  def load_sets
    @sets = Show.possible_sets
  end
end
