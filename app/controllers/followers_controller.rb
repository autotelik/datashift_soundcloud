class FollowersController < ApplicationController

  include SoundcloudTools::Access

  before_action :authenticate_user!

  def form_factory
    FollowersForm.new(client)
  end

  def index
    connect_soundcloud_client
    render :index, locals: { form: form_factory }
  end

end