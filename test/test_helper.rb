# frozen_string_literal: true

ENV['RAILS_ENV'] ||= 'test'
require_relative '../config/environment'
require 'rails/test_help'
require 'webmock/minitest'

class ActiveSupport::TestCase
  parallelize(workers: :number_of_processors)

  fixtures :all

  OmniAuth.config.test_mode = true
  WebMock.allow_net_connect!

  def discord_account_mock(name, uid)
    auth_hash = {
      provider: 'discord',
      uid: uid,
      info: {
        name: name
      },
      extra: {
        raw_info: {
          discriminator: '1234'
        }
      }
    }
    OmniAuth.config.mock_auth[:discord] = OmniAuth::AuthHash.new(auth_hash)
  end
end
