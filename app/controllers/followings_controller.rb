class FollowingsController < ApplicationController

  include SoundcloudTools::Access
  include SoundcloudTools::Connection

  before_action :authenticate_user!
  before_action :authenticate_user!

  def form_factory
    FollowingForm.new(client)
  end

  def unfollow_multiple
    connect_soundcloud_client

    ids = params[:unfollow_form].fetch(:unfollow, []) #"=>["66651257", "34839820"]}

    puts "ids", ids.inspect

    ids.each do |id|
      puts "You are about to delete [#{id}]"
      client.delete("/me/followings/#{id}")
      begin
        client.get("/me/followings/#{id}")
      rescue Soundcloud::ResponseError => e
        #if e.response.status == '404'
          puts 'You are not following user 3207', e.response.inspect
       # end
      end
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