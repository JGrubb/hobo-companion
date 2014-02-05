require 'spec_helper'

describe Show do
  it "is valid with a date and venue" do
    show = Show.new(date: Date.today, venue_id: 1)
    expect(show).to be_valid
  end
  it "is invalid without a date" do
    show = Show.new(date: nil, venue_id: 1)
    expect(show).to have(1).error_on(:date)
  end
  it "is invalid without a venue" do
    show = Show.new(date: Date.today, venue_id: nil)
    expect(show).to have(1).error_on(:venue_id)
  end
  it "is invalid if a show already exists in this venue on this day" do
    show = Show.create(date: Date.today, venue_id: 1)
    show2 = Show.new(date: Date.today, venue_id: 1)
    expect(show2).to be_invalid
  end
  it "is valid in two different venues on the same day" do
    show = Show.create(date: Date.today, venue_id: 1)
    show2 = Show.new(date: Date.today, venue_id: 2)
    expect(show2).to be_valid
  end
end
