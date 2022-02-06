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

    Bot.instance.message(with_text: 'Chatrank!') do |event|
      period      = Time.current.strftime('%Y-%m')
      ranks       = Rank.monthly(rankable_type: 'Server', rankable_id: event.server.id, period: period)
      badges      = ['🥇', '🥈', '🥉']
      leaderboard = ranks.map.with_index do |rank, index|
        order = index < 3 ? badges[index] : index + 1
        "#{order}. #{rank.user.username_discriminator}"
      end.join("\n")
      response = <<~TEXT
        以下は今月（#{period}）のチャットユーザーのランキングです~

        #{leaderboard}
      TEXT
      event.respond response
    end

    Bot.instance.run
  end
end
