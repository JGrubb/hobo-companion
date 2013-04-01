class VenuesController < ApplicationController
  def index
    @venues = Venue.where(:country => 'USA').order(:state, :city)
    @states = Venue.select(:state).uniq.order(:state)
  end

  def new
  end

  def create
    @venue = Venue.new(params[:venue])
    if @venue.save
      flash[:notice] = "Nice job #{current_user.email}. You added #{@venue.name}"
      redirect_to new_show_path
    else
      redirect_to new_show_path
    end
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
