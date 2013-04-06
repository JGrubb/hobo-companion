class ArchiveWorker
  include Sidekiq::Worker
  include ActiveSupport
  require 'net/http'
  
  def perform(show_id)
    show = Show.find(show_id)
    uri = URI.parse("http://archive.org/advancedsearch.php?q=%22Railroad+Earth%22+and+date%3A%5B#{show.date.strftime('%Y-%m-%d')}%5D&fl%5B%5D=avg_rating&fl%5B%5D=identifier&fl%5B%5D=source&sort%5B%5D=avg_rating+desc&indent=yes&output=json")
    begin
      request = Net::HTTP.get uri
      response = ActiveSupport::JSON.decode request
      if response["response"]["numFound"].to_i > 0
        show.update_attribute(:archive_info, response["response"])
      end
    rescue
    end
  end  
  
end