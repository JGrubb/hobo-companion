require 'spec_helper'

describe Venue do
  before :each do
    @venue = Venue.new(
      name: "The Barn",
      city: "Stillwater",
      state: "NJ",
      country: "USA"
    )
  end

  it "is valid with a name, city, state, and country" do
    expect(@venue).to be_valid
  end

  it "is invalid without a name" do
    @venue.name = nil
    expect(@venue).to have(1).error_on(:name)
  end

  it "is invalid without a city" do
    @venue.city = nil
    expect(@venue).to have(1).error_on(:city)
  end

  it "is invalid without a state" do
    @venue.state = nil
    expect(@venue).to have(1).error_on(:state)
  end

  it "is invalid without a country" do
    @venue.country = nil
    expect(@venue).to have(1).error_on(:country)
  end
end
