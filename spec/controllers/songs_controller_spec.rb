require 'spec_helper'

describe SongsController do
  
  describe "GET index" do
    it "gets all the songs, alphabetically" do
      song1 = create :song, title: "All Apologies"
      song2 = create :song, title: "Bye Bye Blackbird"
      song3 = create :song, title: "Cry Baby"
      get :index
      expect(assigns(:songs)).to eq([song1, song2, song3])
    end
  end
end
