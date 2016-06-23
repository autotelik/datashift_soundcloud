class IndexNoFollowBackForm < BaseForm

  include SoundcloudTools::Connection
  extend SoundcloudTools::Connection

  property :whitelist_ids, virtual: true

  attr_reader :following

  def initialize(client)
    super client

    # people I follow
    @following = get_collection(client, '/me/followings', :order => 'username')#, :limit => page_size
    #@following = get_page(client, '/me/followings', :order => 'username')#, :limit => page_size

    following_ids = @following.collect(&:id)

    # people who follow me
    followers = get_collection(client, '/me/followers')

    no_follow_back_ids = following_ids - followers.collect(&:id)

    # delete anyone who does follow us back
    @following.delete_if {|f| ! no_follow_back_ids.include?(f.id) }
  end

  def whitelist_ids=(id)
    super [id]
  end

  def params_key
    :tbd
  end
end
