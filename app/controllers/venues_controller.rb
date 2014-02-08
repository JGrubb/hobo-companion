class VenuesController < ApplicationController
  before_action :require_user, except: [:index, :show]
  def index
    @venues = Venue.order(:state, :city)
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
      flash[:error] = "For some reason there was a problem there."
      redirect_to new_show_path
    end
  end

  def show
    @venue = Venue.find(params[:id])
    @shows = @venue.shows
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
