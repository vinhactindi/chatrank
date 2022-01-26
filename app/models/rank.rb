# frozen_string_literal: true

class Rank < ApplicationRecord
  after_save :update_server_messages_count!

  belongs_to :user, optional: true
  belongs_to :rankable, polymorphic: true

  scope :monthly, lambda { |rankable_type:, rankable_id:, period: Time.current.strftime('%Y-%m')|
                    where(rankable_type: rankable_type).where(rankable_id: rankable_id).where(period: period).order(messages_count: :desc)
                  }

  def self.increment_channel_messages_count!(user_id:, user_name:, user_discriminator:, channel_id:, timestamp:)
    period = timestamp.strftime('%Y-%m')
    user = User.find_or_create_by!(id: user_id) do |u|
      u.username = user_name
      u.discriminator = user_discriminator
    end
    channel = Channel.find_or_create_by!(id: channel_id) { |c| c.server_id = server_id }
    rank = Rank.find_or_create_by!(user_id: user.id, rankable_type: 'Channel', rankable_id: channel.id, period: period)
    rank.messages_count += 1
    rank.save
  end

  def update_server_messages_count!
    return if rankable_type == 'Server'

    changes = saved_change_to_attribute(:messages_count)
    changed = saved_change_to_attribute?(:messages_count)
    by = changed ? changes[1] - changes[0] : messages_count
    rank = Rank.find_or_create_by!(user_id: user_id, rankable_type: 'Server', rankable_id: rankable.server_id, period: period)
    rank.messages_count += by
    rank.save
  end
end
