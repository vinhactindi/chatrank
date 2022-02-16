# frozen_string_literal: true

class Bot
  include Singleton

  def self.instance
    @@instance ||= Discordrb::Commands::CommandBot.new token: ENV['DISCORD_BOT_TOKEN'], prefix: 'chatrank!'
  end

  def self.run
    Bot.instance.message do |event|
      Rank.increment_channel_messages_count_by_discord_event!(event)
    end

    leaderboard_description = 'Leaderboard for this month or the month you entered.'
    Bot.instance.command(:leaderboard, min_args: 0, max_args: 1, description: leaderboard_description, usage: 'leaderboard [2020-02]') do |event, period|
      period ||= Time.current.strftime('%Y-%m')
      ranks = Rank.monthly(rankable_type: 'Server', rankable_id: event.server.id, period: period)
      badges = ['🥇', '🥈', '🥉']
      leaderboard = if ranks.any?
                      ranks.map.with_index do |rank, index|
                        order = index < 3 ? badges[index] : index + 1
                        "#{order}. #{rank.user.username_discriminator}"
                      end.join("\n")
                    else
                      'まだランキングされているユーザーはいません!'
                    end

      <<~TEXT
        *以下は「#{period}」のチャットユーザーのランキングです~*

        #{leaderboard}
      TEXT
    end

    Bot.instance.run
  end
end
