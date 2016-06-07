class SoundcloudController < ApplicationController

  include SoundcloudTools::Access

  def connect
    authenticate_user!

    redirect_to soundcloud_client.authorize_url(:display => "popup")
  end

  def connected
    authenticate_user!

    if( params[:error].nil? && params[:code] )

      logger.info("Exchanging token #{params[:code].inspect}")

      access_token = soundcloud_client.exchange_token(code: params[:code])

      logger.info("access_token #{access_token.inspect}")

      client = Soundcloud.new(access_token: access_token.access_token)

      logger.info("client #{client.inspect}")

      me = client.get("/me")

      logger.info("me #{me.inspect}")

      assign_soundcloud_user(me, access_token)
    end

    redirect_to root_path
  end

  private

  def assign_soundcloud_user( me, access_token)
    current_user.update_attributes!(
      soundcloud_user_id: me.id,
      soundcloud_username: me.username,
      soundcloud_access_token: access_token.access_token,
      soundcloud_refresh_token: access_token.refresh_token,
      soundcloud_expires_at: access_token.expires_at
    ) if(current_user)

    current_user.reload
  end

  def soundcloud_client
    return client if client
    create_client
  end


end