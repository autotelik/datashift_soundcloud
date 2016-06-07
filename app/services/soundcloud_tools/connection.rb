require 'soundcloud'

module SoundcloudTools

  module Connection

    def get_collection( client, uri, page_size = 10 )
      results = client.get uri, :order => 'created_at', :limit => page_size

      collection = results.collection

      until(results[:next_href].blank?)
        results = client.get(results["next_href"])
        collection += results.collection
      end
      collection
    end

  end
end

