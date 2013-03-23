class VenuesController < ApplicationController
  def index
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
