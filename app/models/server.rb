# frozen_string_literal: true

class Server < ApplicationRecord
  belongs_to :user
  has_many :channels, dependent: :delete_all
  has_many :ranks, as: :rankable, dependent: :delete_all

  def self.where_or_create_by_discord_api_response!(response_str, user_id:)
    servers = []
    JSON.parse(response_str).select { |hash| hash['owner'] }.each do |hash|
      id = hash['id']
      server = Server.find_or_create_by!(id: id) do |s|
        s.user_id = user_id
      end
      server.update(name: hash['name'], user_id: user_id)
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
