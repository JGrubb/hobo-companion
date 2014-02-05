require 'spec_helper'

describe VenuesController do
  
  describe "GET index" do
    it "assigns all venues as @venues" do
      venue = create :venue
      get :index
      expect(assigns(:venues)).to eq([venue])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET show" do
    it "assigns the requested venue as @venue" do
      venue = create :venue
      get :show, {id: venue.id}
      expect(assigns(:venue)).to eq(venue)
    end
  end

  describe "POST create" do
    describe "Unauthorized users" do
      it "prevents anonymous users from creating new venues"
      it "redirects to the login page"
    end

    describe "Authorized users" do
      it "allows registered users to create new venues"
      it "redirects to the new show page"
    end
  end

end
