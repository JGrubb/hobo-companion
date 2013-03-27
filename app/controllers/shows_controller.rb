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
