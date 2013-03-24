class VenuesController < ApplicationController
  def index
    @venues = Venue.where(:country => 'USA').order(:state, :city)
    @states = Venue.select(:state).uniq.order(:state)
  end

  def new
  end

  def create
  end

  def show
    @venue = Venue.find(params[:id])
    @shows = Show.where(:venue_id => @venue.id)
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
