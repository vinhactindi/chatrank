# frozen_string_literal: true

class Channel < ApplicationRecord
  has_many :children, class_name: 'Channel', foreign_key: 'parent_id', dependent: :nullify, inverse_of: :parent
  belongs_to :parent, class_name: 'Channel', optional: true, inverse_of: :children
  belongs_to :server
  has_many :ranks, as: :rankable, dependent: :delete_all

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
end
