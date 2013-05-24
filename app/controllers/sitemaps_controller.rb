class SitemapsController < ApplicationController
  def sitemap
    @shows = Show.all
    @songs = Song.all
    @venues = Venue.all

    respond_to do |format|
      format.xml
    end
  end
end
