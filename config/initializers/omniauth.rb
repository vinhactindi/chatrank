Rails.application.config.middleware.use OmniAuth::Builder do
  provider :discord, ENV['DISCORD_CLIENT_ID'], ENV['DISCORD_CLIENT_SECRET'], scope: 'guilds identify bot', permissions: 0x0000000000000400 + 0x0000000000000800 + 0x0000000000010000
end
