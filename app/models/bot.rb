# frozen_string_literal: true

class Bot
  include Singleton

  def self.instance
    @@instance ||= Discordrb::Bot.new token: ENV['DISCORD_BOT_TOKEN']
  end

  def self.run
    Bot.instance.message do |event|
      Rank.increment_channel_messages_count!(user_id: event.user.id,
                                             user_name: event.user.name,
                                             user_discriminator: event.user.discriminator,
                                             channel_id: event.channel.id,
                                             timestamp: event.timestamp)
    end

    Bot.instance.run
  end
end
