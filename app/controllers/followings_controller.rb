class FollowingsController < ApplicationController

  include SoundcloudTools::Access

  before_action :authenticate_user!

  def form_factory
    FollowingForm.new(client)
  end

  def unfollow_multiple
    connect_soundcloud_client

    ids = params[:unfollow_form].fetch(:unfollow, [])

    ids.each do |id|
      client.delete("/me/followings/#{id}")
      Rails.logger.info("You no longer follow #{id}")
    end

    redirect_to action: :index
  end

  def index
    connect_soundcloud_client

    render :index, locals: { form: form_factory }
  end

  def index_no_follow_back
    connect_soundcloud_client

    render :index_no_follow_back, locals: { form: IndexNoFollowBackForm.new(client) }
  end

end