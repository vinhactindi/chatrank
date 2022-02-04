# frozen_string_literal: true

class User < ApplicationRecord
  has_many :servers, dependent: :delete_all
  has_many :ranks, dependent: :delete_all

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
    end
  end

  def username_discriminator
    "#{username}##{discriminator}"
  end
end
