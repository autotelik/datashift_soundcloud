class FollowersForm < BaseForm

  include SoundcloudTools::Connection
  extend SoundcloudTools::Connection

  attr_reader :followers

  def initialize(client)
    super client

    # All my Followers
    @followers = get_collection(client, '/me/followers')

    # People I follow back
    following = get_collection(client, '/me/followings', :order => 'username')

    following_ids = following.collect(&:id)

    not_following_back = followers.collect(&:id) - following_ids

    @followers.each do |x| x["no_follow_back"] = not_following_back.include?(x.id) end
  end


  def params_key
    :tbd
  end
end
