xml.instruct! :xml
xml.urlset :xmlns => "http://www.sitemaps.org/schemas/sitemap/0.9" do

  for show in @shows
    xml.url do
      xml.loc show_url(show)
      xml.lastmod (Date.today - 1.week).strftime("%Y-%m-%d")
      xml.changefreq "monthly"
      xml.priority "0.5"
    end
  end
  for song in @songs
    xml.url do
      xml.loc song_url(song)
      xml.lastmod (Date.today - 1.week).strftime("%Y-%m-%d")
      xml.changefreq "monthly"
      xml.priority "0.5"
    end
  end
  for venue in @venues
    xml.url do
      xml.loc venue_url(venue)
      xml.lastmod (Date.today - 1.week).strftime("%Y-%m-%d")
      xml.changefreq "monthly"
      xml.priority "0.5"
    end
  end
end
