require 'spec_helper'

describe Version do
  it "is valid with a show_id and song_id" do
    version = Version.new(song_id: 1, show_id: 1)
    expect(version).to be_valid
  end

  it "is invalid without a show_id and song_id" do
    version = Version.new
    expect(version).to be_invalid
  end

  it "is invalid without a show_id" do
    version = Version.new(song_id: 1)
    expect(version).to have(1).error_on(:show_id)
  end

  it "is invalid without a song_id" do
    version = Version.new(show_id: 1)
    expect(version).to have(1).error_on(:song_id)
  end

  it "is in a unique position within the show" do
    version = Version.create(show_id: 1, song_id: 1, position: 1)
    version2 = Version.new(show_id: 1, song_id: 2, position: 1)
    expect(version2).to be_invalid
  end
end
