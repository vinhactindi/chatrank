# frozen_string_literal: true

class Server < ApplicationRecord
  belongs_to :user, optional: true
  has_many :channels, dependent: :delete_all
  has_many :ranks, as: :rankable, dependent: :delete_all

  def self.where_or_create_by_discord_api_response!(response_str, user_id:)
    servers = []
    JSON.parse(response_str).each do |hash|
      server         = Server.find_or_create_by!(id: hash['id'])
      server.user_id = user_id if hash['owner']
      server.name    = hash['name']
      server.save

      guild             = Guild.find_or_create_by!(user_id: user_id, server_id: server.id)
      guild.permissions = hash['permissions']
      guild.save

      servers << server
    end

    servers
  end

  def read_history_messages
    if update(updating: true)
      ranks.destroy_all
      channels.each do |channel|
        channel.ranks.destroy_all
        channel.update_messages_count!(ENV['DISCORD_BOT_TOKEN'])
      end
    end
    update(updating: false)
  end
end
