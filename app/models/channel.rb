# frozen_string_literal: true

class Channel < ApplicationRecord
  LIMIT_MESSAGES = 100
  has_many :children, class_name: 'Channel', foreign_key: 'parent_id', dependent: :nullify, inverse_of: :parent
  belongs_to :parent, class_name: 'Channel', optional: true, inverse_of: :children
  belongs_to :server
  has_many :ranks, as: :rankable, dependent: :delete_all

  delegate :manage_by?, to: :server

  def self.where_or_create_by_discord_api_response!(response_str, server_id:)
    channels = []
    JSON.parse(response_str).each do |hash|
      channel = Channel.find_or_create_by!(id: hash['id']) { |c| c.server_id = server_id }
      channel.update(name: hash['name'], channel_type: hash['type'].to_i, position: hash['position'], parent_id: hash['parent_id'])
      channels << channel
    end

    channels
  end

  def self.find_or_create_by_discord_event!(event)
    Channel.find_or_create_by!(id: event.channel.id) do |c|
      c.server_id    = event.server.id
      c.name         = event.channel.name
      c.channel_type = event.channel.type
      c.position     = event.channel.position
      c.parent_id    = event.channel.parent_id
    end
  end

  def all_messages(token, before = nil)
    response = Discordrb::API::Channel.messages("Bot #{token}", id, LIMIT_MESSAGES, before, nil)
  rescue Discordrb::Errors::NoPermission
    []
  else
    messages = JSON.parse(response)

    if messages.length < LIMIT_MESSAGES
      messages
    else
      messages + all_messages(token, messages.last['id'])
    end
  end

  def update_messages_count!(token)
    messages = all_messages(token)
    groups   = messages.group_by { |m| [m['author']['id'], Time.zone.parse(m['timestamp']).strftime('%Y-%m')] }
    groups.each do |key, value|
      user_id, period     = key
      user                = User.find_or_create_by!(id: user_id) do |u|
        u.username = value.first['author']['username']
        u.discriminator = value.first['author']['discriminator']
      end
      Guild.find_or_create_by!(user_id: user_id, server_id: server.id)
      messages_count      = value.length
      rank                = Rank.find_or_create_by!(user_id: user.id, rankable_type: 'Channel', rankable_id: id, period: period)
      rank.messages_count = messages_count
      rank.save
    end
  end
end
