# frozen_string_literal: true

module ApplicationHelper
  def invite_bot_url
    "https://discord.com/api/oauth2/authorize?client_id=#{ENV['DISCORD_CLIENT_ID']}&permissions=68608&scope=bot"
  end
end
