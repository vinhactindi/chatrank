# frozen_string_literal: true

class User < ApplicationRecord
  def self.find_or_create_from_auth_hash!(auth_hash)
    provider = auth_hash[:provider]
    uid = auth_hash[:uid]
    name = auth_hash[:info][:name]
    image_url = auth_hash[:info][:image]
    discriminator = auth_hash[:extra][:raw_info][:discriminator]

    User.find_or_create_by!(provider: provider, uid: uid) do |user|
      user.username = name
      user.discriminator = discriminator
      user.avatar_url = image_url
    end
  end
end
