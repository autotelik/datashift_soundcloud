class SoundcloudController < ApplicationController


  include SoundcloudTools::Access

  def connect
    redirect_to soundcloud_client.authorize_url
  end

  def connected
    puts "Return params"
=begin
    if params[:error].nil?
      soundcloud_client.exchange_token(:code => params[:code])
      me = soundcloud_client.get("/me")

      login_as User.find_or_create_by_soundcloud_user_id({
                                                           :soundcloud_user_id  => me.id,
                                                           :soundcloud_username => me.username
                                                         })

      current_user.update_attributes!({
                                        :soundcloud_access_token  => soundcloud_client.access_token,
                                        :soundcloud_refresh_token => soundcloud_client.refresh_token,
                                        :soundcloud_expires_at    => soundcloud_client.expires_at,
                                      })
    end
=end
    render :layout => false
  end

  def disconnect
    login_as nil
    redirect_to root_path
  end

  private

  def soundcloud_client
   # return @client if @client
    create_client
  end


end