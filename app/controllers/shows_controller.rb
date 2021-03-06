class ShowsController < ApplicationController
  before_filter :require_user, :except => [:show, :index, :welcome, :tabs, :shows_per_year, :shows_per_month, :year]
  before_filter :get_user_shows, :only => [:index, :tabs, :year]
 
  require 'yaml'
  
  def index
    @user = User.new
    @description = "The definitive site for Railroad Earth community, RRE lyrics, show and setlist information, an who knows what else to come..."
    respond_to do |format|
      format.html
      format.json { render :json => @shows }
    end
  end

  def tag_show
    @show = Show.find(params[:id])
    current_user.shows << @show
    respond_to do |format|
      format.html { redirect_to shows_path }
      format.js
    end
  end

  def delete_tag
    @show = Show.find(params[:id])
    current_user.shows.delete(@show)
    respond_to do |format|
      format.html {redirect_to shows_path}
      format.js
    end
  end

  def show
    @show = Show.joins(:venue).select('shows.*, venues.name, venues.city, venues.state, venues.id as venue_id').friendly.find(params[:id])
    @possible_sets = Show.possible_sets
    @songs = Version.joins(:song)
              .order('versions.position ASC')
              .select('versions.position, versions.set_number, versions.transition, versions.song_notes, songs.title, songs.is_song, songs.id, songs.slug')
              .where(:show_id => @show.id)
    @title = "Setlist for #{@show.date}"
    @description = "Show and setlist info for Railroad Earth on #{@show.date} at #{@show.name} - #{@show.city}, #{@show.state}"
    @archive_info = @show.archive_info ? Psych.load(@show.archive_info) : nil
  end

  def new
    @venue = Venue.new
    @show = Show.new
    @show.versions.build
    load_sets
    @venues = Venue.all
  end

  def create
    @show = Show.new(params[:show])
    songs = params[:show][:versions_attributes]
    check_song_id_for_new(songs, params)
    karma_check(@show, current_user, 100)
    @show.updated_by = current_user.id
    if @show.save
      #ArchiveWorker.perform_async(@show.id)
      redirect_to @show
    else
      redirect_to shows_path
    end
  end

  def edit
    @show = Show.friendly.find(params[:id])
    @venue = @show.venue
    @show.versions.build
    load_sets
  end

  def update
    @show = Show.friendly.find(params[:id])
    songs = params[:show][:versions_attributes]
    check_song_id_for_new(songs, params)
    karma_check(@show, current_user, 25)
    respond_to do |format|
      if @show.update_attributes(params[:show])
        ArchiveWorker.perform_async(@show.id)
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
    @shows = Show.with_venue
    if current_user
      @user_last_show = current_user.shows.order('date desc').first
    end
    @most_recent_show = @shows.first
    @recently_added = @shows.limit(5).offset(1)
    @first_show = @shows.last
    @recently_updated_songs = Song.where(is_song: true).order(:created_at).reverse_order.limit(5)
    @user = User.new
    @users = User.joins(:shows).select('users.id as user_id, shows.id as show_id')
    @tagging_users_count = @users.uniq! { |u| u[:user_id]}.count(:all)
    @years = @shows.map { |s| s.date.year }.uniq.sort
    @user_shows = []
    if current_user 
      @user_shows = current_user.shows.pluck :id
    end
    respond_to do |format|
      format.html
      format.json { render :json => @shows}
    end
  end

  def tabs
    @years = @shows.map { |s| s.date.year }.uniq.sort
    render :layout => false
  end
  
  def shows_per_year
    @shows = Show.select('YEAR(date) as year, count(*) as count').group('YEAR(date)')
    render json: @shows
  end
  
  def shows_per_month
    @shows = Show.select('YEAR(date) as year, MONTH(date) as month, count(*) as count').group('YEAR(date), MONTH(date)')
    render json: @shows
  end
  
  private
  
  def get_user_shows
    @shows = Show.joins(:venue).select('shows.*, venues.name, venues.city, venues.state').order('shows.date desc')
    @user_shows = []
    if current_user 
      @user_shows = current_user.shows.pluck :id
    end
  end

  def check_song_id_for_new(songs, params)
    songs.each do |song|
      if (song[1][:song_id].empty? || song[1][:song_id].to_i == 0)
        tune = Song.find_or_create_by_title(song[1][:song_id])
        params[:show][:versions_attributes][song[0]][:song_id] = tune.id
      end
    end
  end
  
  def load_sets
    @sets = Show.possible_sets
  end
end
