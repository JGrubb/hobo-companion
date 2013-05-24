require 'spec_helper'

describe SitemapsController do

  describe "GET 'sitemap'" do
    it "returns http success" do
      get 'sitemap'
      response.should be_success
    end
  end

end
