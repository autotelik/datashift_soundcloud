class FollowingForm < BaseForm

  include SoundcloudTools::Connection
  extend SoundcloudTools::Connection

  property :whitelist_ids, virtual: true

  attr_reader :following


  def initialize(client)
    super client

    # people I follow
    @following = get_collection(client, '/me/followings', :order => 'username')
   # @following = get_page(client, '/me/followings', :order => 'username')#, :limit => page_size

    following_ids = following.collect(&:id)

    # people who follow me
    followers = get_collection(client, '/me/followers')

    no_follow_back = following_ids - followers.collect(&:id)

    Rails.logger.info("No follow back from #{no_follow_back.inspect}")

    @following.each do |x| x["no_follow_back"] = no_follow_back.include?(x.id) end
  end

  def whitelist_ids=(id)
    super [id]
  end

  def params_key
    :tbd
  end
end
