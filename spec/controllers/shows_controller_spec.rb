require 'spec_helper'

describe ShowsController do
  describe "GET welcome" do
    before :each do
      @show1 = create :show
      @show2 = create(:show, date: 1.week.ago)
      @show3 = create(:show, date: 2.weeks.ago)
      @show4 = create(:show, date: 3.weeks.ago)
      @show5 = create(:show, date: 4.weeks.ago)
      @show6 = create(:show, date: 5.weeks.ago)
    end

    it "assigns the shows as @shows" do
      get :welcome
      expect(assigns(:shows)).to eq([@show1, @show2, @show3, @show4, @show5, @show6])
    end

    it "assigns the current_user's last show as @user_last_show"

    it "assigns the most recent show as @most_recent_show" do
      get :welcome
      expect(assigns(:most_recent_show)).to eq(@show1)
    end

    it "assigns the first show as @first_show" do
      get :welcome
      expect(assigns(:first_show)).to eq(@show6)
    end

    it "assigns recently updated lyrics as @recently_updated_songs" do
      song_batch = []
      5.times { |n| song_batch << Song.create(title: "Song #{n}") }
      get :welcome
      expect(assigns(:recently_updated_songs)).to eq(song_batch)
    end

    it "assigns a new user to @user"
    it "assigns the number of users who have tagged their shows as @tagging_users_count"
  end

  describe "GET show" do
    before :each do
      @show = create :show
    end

    it "assigns the possible sets as @possible_sets" do
      get :show, { id: @show.id }
      expect(assigns(:possible_sets)).to eq(Show::possible_sets)
    end

    it "assigns the show as @show"
    it "assigns the setlist as @songs"
    it "assigns the title as @title"
    it "assigns the description as @description"
    it "correctly orders the setlist"
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

  describe "POST create" do
    context "as unauthorized user" do
      it "prevents unauthorized users from creating new shows" do
        post :create, { show: attributes_for(:show) }
        expect(response.status).to eq 302
      end
      it "redirects unauthorized users to the new session path" do
        post :create, { show: attributes_for(:show) }
        expect(response).to redirect_to new_user_session_path
      end
    end

    context "as authorized user" do
      login_user
      it "assigns the updating_user"
      it "creates new songs if they don't already exist"
      it "redirects to the show path"
    end
  end
end
