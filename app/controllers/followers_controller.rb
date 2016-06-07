class FollowersController < ApplicationController

  include SoundcloudTools::Access
  include SoundcloudTools::Connection

  before_action :authenticate_user!

  def index
    page_size = 50

    connect_soundcloud_client

    # people I follow
    followings = get_collection(client, '/me/followings', page_size)#, :order => 'created_at', :limit => page_size
    sorted_by_username = followings.sort_by(&:username)

    followings_ids = followings.collect(&:id)

    # people who follow me
    followers = get_collection(client, '/me/followers', page_size)

    followers_ids = followers.collect(&:id)

    unfollow = followings_ids - followers_ids

    @followers = {}

    sorted_by_username.each do |x|
      @followers[x] = unfollow.include?(x.id)
    end
=begin
    sorted_by_username.each do |x|
      status = begin
        puts "WOAH", results.inspect
        client.get("/users/#{x.id}/followings/#{current_user.soundcloud_user_id}")
      rescue Soundcloud::ResponseError => e
        puts e.message.inspect
        puts "You are not following user #{x.id} (#{current_user.soundcloud_user_id})"
        if e.response.status == '404'
          :no_follow_back
        else
          :follows_back
        end
      end
      @followers[x] = status
    end
=end
    @followers

  end

end