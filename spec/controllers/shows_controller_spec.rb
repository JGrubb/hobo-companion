require 'spec_helper'

describe ShowsController do
  describe "GET index" do
    it "assigns all shows as @shows"
    it "renders the index template"
    it "assigns the description as @description"
  end

  describe "GET show" do
    it "assigns the possible sets as @sets"
    it "assigns the show as @show"
    it "assigns the setlist as @songs"
    it "assigns the title as @title"
    it "assigns the description as @description"
  end

  describe "GET new" do
    context "as unauthorized user" do
      it "prevents unauthorized users from getting to the new show form" do
        get :new, {}
        expect(response.status).to eq(302)
      end
      it "redirects unauthorized users to the sign-in page" do
        get :new, {}
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "as authorized user" do
      login_user
      
      before :each do
        get :new, {}
      end

      it "assigns the new show as @show" do
        expect(assigns(:show)).to be_a(Show)
      end

      it "assigns the new venue as @venue" do
        expect(assigns(:venue)).to be_a(Venue)
      end

      it "builds a version" do
        show = build :show
        expect(show.versions).to_not be nil
      end

      it "assigns all venues as @venues" do
        venue = create :venue
        expect(assigns(:venues)).to eq([venue])
      end

    end
  end

  describe "POST tag_show" do
    it "allows authorized users to tag shows"
    it "prevents unauthorized users from tagging shows"
    it "properly assigns show tags"
    it "prevents the user from tagging the same sow twice"
    it "prevents unauthorized users from tagging shows"
  end

  describe "DELETE tag_show" do
    it "gracefully prevents improper tag deletions"
    it "prevents users from deleting each other's tags"
    it "prevents unauthorized users from deleting anyone's tags"
  end
end
