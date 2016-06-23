class CreateWhitelistFollowers < ActiveRecord::Migration
  def change
    # Followers we do not want to unfollow regardless of follow back etc
    create_table :whitelist_followers do |t|
      t.references :user
      t.string     :soundcloud_id
      t.string     :soundcloud_username
    end

  end
end
