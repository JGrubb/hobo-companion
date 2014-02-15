require 'spec_helper'

describe VenuesController do
  
  describe "GET index" do
    it "assigns all venues as @venues" do
      venue = create :venue
      venue2 = create :venue, state: "Alabama"
      get :index
      expect(assigns(:venues)).to eq([venue2, venue])
    end

    it "renders the index template" do
      get :index
      expect(response).to render_template(:index)
    end
  end

  describe "GET show" do
    before :each do
      @venue = create :venue
    end

    it "assigns the requested venue as @venue" do
      get :show, { id: @venue.id }
      expect(assigns(:venue)).to eq(@venue)
    end
     
     it "renders the show template" do
       get :show, { id: @venue.id }
       expect(response).to render_template(:show)
     end
  end

  describe "POST create" do
    context "Unauthorized users" do
      it "prevents anonymous users from creating new venues" do
        post :create, { venue: FactoryGirl.attributes_for(:venue) }
        expect(assigns(:venue)).to be_nil
      end

      it "redirects to the login page" do
        post :create, { venue: FactoryGirl.attributes_for(:venue) }
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "Authorized users" do
      login_user

      it "allows registered users to create new venues" do
        expect {
          post :create, { venue: FactoryGirl.attributes_for(:venue) }
        }.to change(Venue, :count).by 1
      end

      it "redirects to the new show page" do
        post :create, { venue: FactoryGirl.attributes_for(:venue) }
        expect(response).to redirect_to new_show_path
      end
    end
  end
end
