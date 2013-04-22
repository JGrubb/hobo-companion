class ShowsController < ApplicationController
  before_filter :require_user, :except => [:show, :index]
  
  require 'yaml'
  
  def index
    @shows = Show.includes(:venue).order('date desc')
    @description = "The definitive site for Railroad Earth community, RRE lyrics, show and lsetlist information, an who knows what else to come..."
  end

  def show
    @show = Show.find(params[:id])
    @venue = Venue.find(@show.venue_id)
    @possible_sets = SongInstance.select(:set_number).uniq.order('set_number ASC')
    @songs = SongInstance.where(:show_id => @show.id).includes(:song).order('position ASC')
    @title = "Setlist for #{@show.date}"
    @description = "Show and setlist info for Railroad Earth on #{@show.date} at #{@venue.name} - #{@venue.city}, #{@venue.state}"
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
    if @show.delete
      redirect_to shows_path
    end
  end


  def year
    @shows = Show.where('extract(year from date) = ?', params[:year]).includes(:venue)
    render :index
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
    @sets_objs = SongInstance.select(:set_number).uniq.order(:set_number)
    @sets ||= []
    @sets_objs.each do |s|
      @sets << s.set_number unless s.set_number.blank?
    end
  end
end
