require 'spec_helper'

describe Song do
  it "is valid with a title" do
    post = Song.new(title: "Shit Creek")
    expect(post).to be_valid
  end

  it "is invalid without a title" do
    post = Song.new
    expect(post).to be_invalid
  end
end
