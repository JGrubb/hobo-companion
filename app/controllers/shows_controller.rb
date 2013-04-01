class ShowsController < ApplicationController
  
  def index
    @shows = Show.includes(:venue).order('date desc')
  end

  def show
    @show = Show.find(params[:id])
    @venue = Venue.find(@show.venue_id)
    @possible_sets = SongInstance.select(:set_number).uniq
    @songs = SongInstance.where(:show_id => @show.id).joins(:song).order('position asc')
  end

  def new
    @venue = Venue.new
    @show = Show.new
    @show.song_instances.build
    @sets_objs = SongInstance.select(:set_number).uniq.order(:set_number)
    @sets ||= []
    @sets_objs.each do |s|
      @sets << s.set_number unless s.set_number.blank?
    end
    @venues = Venue.all
  end

  def create
    @show = Show.new(params[:show])
    if @show.save
      redirect_to @show
    else
      redirect_to edit_show_path(@show)
    end
  end

  def edit
    @show = Show.find(params[:id])
    @venue = @show.venue
    @show.song_instances.build
    @sets_objs = SongInstance.select(:set_number).uniq.order(:set_number)
    @sets ||= []
    @sets_objs.each do |s|
      @sets << s.set_number unless s.set_number.blank?
    end
  end

  def update
    @show = Show.find(params[:id])
    respond_to do |format|
      if @show.update_attributes(params[:show])
        format.html { redirect_to @show, notice:  "#{@show.date} was successfully updated." }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @show.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
  end
end