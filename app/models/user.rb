# frozen_string_literal: true

class User < ApplicationRecord
  has_many :own_servers, class_name: 'Server', dependent: :nullify
  has_many :ranks, dependent: :destroy
  has_many :guilds, dependent: :destroy
  has_many :servers, through: :guilds

  has_one :last_seen_server, class_name: 'Server', dependent: :nullify

  def self.find_or_create_from_auth_hash!(auth_hash)
    uid = auth_hash[:uid]
    name = auth_hash[:info][:name]
    image_url = auth_hash[:info][:image]
    discriminator = auth_hash[:extra][:raw_info][:discriminator]
    token = auth_hash[:credentials][:token]

    user = User.find_or_create_by!(id: uid) do |u|
      u.username      = name
      u.discriminator = discriminator
    end

    user.update({ avatar_url: image_url, token: token })

    user
  end

  def self.find_or_create_by_discord_event!(event)
    User.find_or_create_by!(id: event.user.id) do |u|
      u.username      = event.user.name
      u.discriminator = even.user.discriminator

      Guild.find_or_create_by!(user_id: event.user.id, server_id: event.server.id)
    end
  end

  def username_discriminator
    "#{username}##{discriminator}"
  end

  def manage?(object)
    server = object.is_a?(Server) ? object : object.server
    guild  = guilds.find_by(server: server)
    return Discordrb::Permissions.new(guild.permissions_or_zero).manage_server if guild

    false
  end

  def last_seen_server_to_react_prop
    { id: last_seen_server.id.to_s, name: last_seen_server.name } if last_seen_server.present?
  end
end
