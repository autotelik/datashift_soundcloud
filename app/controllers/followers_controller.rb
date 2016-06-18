class FollowersController < ApplicationController

  include SoundcloudTools::Access
  include SoundcloudTools::Connection

  before_action :authenticate_user!

  def form_factory
    FollowersForm.new(client)
  end

  def unfollow
    page_size = 50

    connect_soundcloud_client

    puts "Params"

    if(params[:delete] && params[:delete_id])
      client.delete('/me/followings/3207')
    end

  end


  def index
    page_size = 50

    connect_soundcloud_client

    form = form_factory

    render :index, locals: { form: form }
  end

end