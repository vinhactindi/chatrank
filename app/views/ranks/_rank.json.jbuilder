json.call(rank, :id, :messages_count)
json.user do
  json.username rank.user.username
  json.discriminator rank.user.discriminator
  json.avatar_url rank.user.avatar_url
end
