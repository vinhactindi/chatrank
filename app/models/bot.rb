# frozen_string_literal: true

class Bot
  include Singleton

  def self.instance
    @@instance ||= Discordrb::Bot.new token: ENV['DISCORD_BOT_TOKEN']
  end
end
