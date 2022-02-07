json.call(rank, :id, :messages_count)
json.user do
  json.username rank.user.username
  json.discriminator rank.user.discriminator
end
