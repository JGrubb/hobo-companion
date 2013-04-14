class ArchiveWorker
  include Sidekiq::Worker
  include ActiveSupport
  require 'net/http'
  
  def perform(show_id)
    show = Show.find(show_id)
    uri = URI.parse("http://archive.org/advancedsearch.php?q=collection%3A%22RailroadEarth%22+and+date%3A%22#{show.date.strftime('%Y-%m-%d')}%22&fl%5B%5D=avg_rating&fl%5B%5D=date&fl%5B%5D=format&fl%5B%5D=identifier&sort%5B%5D=date+asc&sort%5B%5D=&sort%5B%5D=&rows=1500&page=1&indent=yes&output=json")
    request = Net::HTTP.get uri
    response = ActiveSupport::JSON.decode request
    if response["response"]["numFound"].to_i > 0
      show.update_attribute(:archive_info, response["response"])
    end
  end  
  
end