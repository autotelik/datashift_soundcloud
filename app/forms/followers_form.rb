class FollowersForm < BaseForm

  include SoundcloudTools::Connection
  extend SoundcloudTools::Connection

  property :whitelist_ids, virtual: true

  attr_reader :following_by_username, :followers


  def initialize(client)
    super client

    # people I follow
    following = get_collection(client, '/me/followings', :order => 'username')#, :limit => page_size

    @following_by_username = following.sort_by(&:username)

    # people who follow me
    @followers = get_collection(client, '/me/followers')

    @followers_ids = followers.collect(&:id)
=begin
        no_follow_back = followings_ids - followers_ids

        @followers = {}

        sorted_by_username.each do |x|
          @followers[x] = no_follow_back.include?(x.id) ? :no_follow_back : :follows_you
        end
=end
  end

  def whitelist_ids=(id)
    super [id]
  end

  def params_key
    :tbd
  end
end
