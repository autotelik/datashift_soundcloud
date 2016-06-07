class FollowersController < ApplicationController

  before_action :authenticate_user!

  def index
    page_size = 200

    max = 20

    client = Soundcloud.new(access_token: current_user.soundcloud_access_token)

    results = client.get '/me/followings', :order => 'created_at', :limit => page_size

    collection = results.collection

    until(results[:next_href].blank?)

      results = client.get(results["next_href"], :limit => page_size)

      puts "NEXT : #{results[:next_href].class} [#{results[:next_href]}]"

      collection += results.collection
    end

    puts "You have #{collection.size} Followers"
    @followers = collection.sort_by(&:username)
  end

end