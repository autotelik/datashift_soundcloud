require 'soundcloud'

module SoundcloudTools

  module Connection

    def get_page( client, uri, options = {})
      results = client.get uri, options

      results.collection
    end

    def get_collection( client, uri, options = {})
      results = client.get uri, options

      collection = results.collection

      until(results[:next_href].blank?)
        results = client.get(results["next_href"])
        collection += results.collection
      end
      collection
    end

  end
end

