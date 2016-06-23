json.array!(@whitelist_followers) do |whitelist_follower|
  json.extract! whitelist_follower, :id
  json.url whitelist_follower_url(whitelist_follower, format: :json)
end
