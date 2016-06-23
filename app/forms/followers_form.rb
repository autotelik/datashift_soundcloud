class FollowersForm < BaseForm

  include SoundcloudTools::Connection
  extend SoundcloudTools::Connection

  property :whitelist_ids, virtual: true

  attr_reader :following, :following_by_username, :following_ids

  attr_reader :followers, :followers_ids

  attr_reader :no_follow_back

  def initialize(client)
    super client

    # people I follow
    @following = get_collection(client, '/me/followings', :order => 'username')#, :limit => page_size
    #@following = get_page(client, '/me/followings', :order => 'username')#, :limit => page_size

    @following_by_username = following.sort_by(&:username)

    @following_ids = following.collect(&:id)

    # people who follow me
    @followers = get_collection(client, '/me/followers')

    @followers_ids = @followers.collect(&:id)

    @no_follow_back = following_ids - followers_ids

    @following_by_username.each do |x|
      x["no_follow_back"] = no_follow_back.include?(x.id)
    end
  end

  def whitelist_ids=(id)
    super [id]
  end

  def params_key
    :tbd
  end
end
