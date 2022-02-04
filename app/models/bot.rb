# frozen_string_literal: true

class Bot
  include Singleton

  def self.instance
    @@instance ||= Discordrb::Bot.new token: ENV['DISCORD_BOT_TOKEN']
  end

  def self.run
    Bot.instance.message do |event|
      Rank.increment_channel_messages_count_by_discord_event!(event)
    end

    Bot.instance.run
  end
end
