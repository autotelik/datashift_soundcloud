require 'soundcloud'

module SoundcloudTools

  module Access

    attr_reader :client
    attr_reader  :redirect_uri

    def config_file
      File.join( Rails.root, "config", "soundcloud.config.yaml")
    end

    def create_client
      puts "Connecting to soundcloud using settings in .env"

      @client = Soundcloud.new(
        :client_id =>  ENV['CLIENT_ID'],
        :client_secret => ENV['CLIENT_SECRET'],
        :redirect_uri => ENV['REDIRECT_URI']
      )
      puts "Connected using REDIRECT_URI #{ENV['REDIRECT_URI']}"
      @client
    end

    def connect_soundcloud_client
      connect_client(current_user.soundcloud_access_token)
    end

    # create a logged in client object with access token
    def connect_client(token)
      @client = Soundcloud.new(access_token: token)
    end


  end
end

