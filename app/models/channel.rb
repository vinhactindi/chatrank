class Channel < ApplicationRecord
  has_many :children, class_name: 'Channel', foreign_key: 'parent_id'
  belongs_to :parent, class_name: 'Channel', optional: true
  belongs_to :server

  def self.where_or_create_by_discord_api_response!(response_str, server_id:)
    channels = []
    JSON.parse(response_str).each do |hash|
      channel = Channel.find_or_create_by!(id: hash['id']) { |c| c.server_id = server_id }
      channel.update(name: hash['name'], channel_type: hash['type'].to_i, position: hash['position'], parent_id: hash['parent_id'])
      channels << channel
    end

    channels
  end
end
